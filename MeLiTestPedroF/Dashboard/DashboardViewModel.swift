//
//  DashboardViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let fetchArticlesUseCase: FetchArticlesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchArticlesUseCase: FetchArticlesUseCaseProtocol = FetchArticlesUseCase()) {
        self.fetchArticlesUseCase = fetchArticlesUseCase
        setupSearchTextObserver()
    }
    
    var showEmptyState: Bool {
        !isLoading && articles.isEmpty
    }
    
    var showArticleList: Bool {
        !isLoading && !articles.isEmpty
    }
    
    var isPresentingError: Binding<Bool> {
        Binding(
            get: { self.errorMessage != nil },
            set: { newValue in
                if !newValue {
                    self.errorMessage = nil
                }
            }
        )
    }
    
    func dismissError() {
        errorMessage = nil
    }
    
    private func setupSearchTextObserver() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.prepareAndFetchArticles()
                }
            }
            .store(in: &cancellables)
    }
    
    func prepareAndFetchArticles() async {
        isLoading = true
        defer { isLoading = false }
        articles = []
        do {
            let result = try await fetchArticlesUseCase.execute(searchText)
            switch result {
            case .success(let fetchedArticles):
                self.articles = fetchedArticles
            case .failure(let error):
                self.errorMessage = errorMessage(for: error)
            }
        } catch {
            self.errorMessage = errorMessage(for: error)
        }
    }
    
    func fetchArticles() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await fetchArticlesUseCase.execute(searchText)
            switch result {
            case .success(let fetchedArticles):
                self.articles = fetchedArticles
            case .failure(let error):
                self.errorMessage = errorMessage(for: error)
            }
        } catch {
            self.errorMessage = errorMessage(for: error)
        }
    }
    
    private func errorMessage(for error: Error) -> String {
        if let apiClientError = error as? APIClientError {
            switch apiClientError {
            case .network(let innerError):
                if let urlError = innerError as? URLError, urlError.code == .notConnectedToInternet {
                    return "No tienes conexión a internet."
                }
            default:
                break
            }
        }
        return "No se pudo cargar la información. Intenta nuevamente."
    }
}
