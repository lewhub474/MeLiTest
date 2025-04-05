//
//  DashboardViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()
    private let fetchArticlesUseCase = FetchArticlesUseCase()

    init() {
        setupSearchTextObserver()
    }

    private func setupSearchTextObserver() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.fetchArticles()
            }
            .store(in: &cancellables)
    }

    func fetchArticles() {
        isLoading = true

        fetchArticlesUseCase.execute(searchText: searchText) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let articles):
                    self?.articles = articles
                case .failure(let error):
                    print("Error fetching articles: \(error)")
                    self?.articles = []
                }
            }
        }
    }
}
