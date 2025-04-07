//
//  DashboardViewModel.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class DashboardViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var city: String = ""
    @Published var showArticleList: Bool = false
    @Published var errorMessage: String?
    @Published var isPresentingError: Bool = false
    
    private let fetchArticlesUseCase: any UseCase<String?, [Article]>
    private let fetchCityUseCase: any UseCase<Any?, String>

    init(
        fetchArticlesUseCase: any UseCase<String?, [Article]> = FetchArticlesUseCase(),
        fetchCityUseCase: any UseCase<Any?, String> = FetchCityUseCase()
    ) {
        self.fetchArticlesUseCase = fetchArticlesUseCase
        self.fetchCityUseCase = fetchCityUseCase
    }
    
    func dismissError() {
        errorMessage = nil
        isPresentingError = false
    }
    
    @MainActor
    func fetchArticles() async {
        isLoading = true
        defer { isLoading = false }
        
        let result = await fetchArticlesUseCase.execute(searchText)
        
        switch result {
        case .success(let fetchedArticles):
            self.articles = fetchedArticles
        case .failure(let error):
            self.errorMessage = errorMessage(for: error)
            self.isPresentingError = true
        }
    }
    
    @MainActor
    func fetchCity() async {
        city = "Obteniendo ubicación..."
        
        let response = await fetchCityUseCase.execute(nil)
        
        switch response {
            case .success(let cityName):
            city = cityName
        case .failure(let error):
            print("Error obteniendo ubicación: \(error.localizedDescription)")
            city = "Error obteniendo ubicación"
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
