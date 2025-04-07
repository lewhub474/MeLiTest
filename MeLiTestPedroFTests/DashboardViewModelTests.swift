//
//  MeLiTestPedroFTests.swift
//  MeLiTestPedroFTests
//
//  Created by Macky on 4/04/25.
//

import Testing
import Foundation
@testable import MeLiTestPedroF

extension Article {
    static var expectedArticles: [Article] {
        return [
            Article(
                id: 1,
                title: "Title",
                summary: "Summary",
                imageUrl: "2025-01-01",
                url: "",
                publishedAt: "")
        ]
    }
    
    static var emptyArticles: [Article] {
        return []
    }
}

struct DashboardViewModelTests {

    @Test(
        arguments: [
            (Article.expectedArticles, false)
        ]
    )
    func fetchArticlesSuccess(articules: [Article], showEmptyState: Bool) async {
        // Given
        var mockUseCase = MockFetchArticlesUseCase()
        let mockFetchCityUseCase = MockFetchCityUseCase()
        mockUseCase.resultToReturn = .success(articules)

        let sut = DashboardViewModel(
            fetchArticlesUseCase: mockUseCase,
            fetchCityUseCase: mockFetchCityUseCase
        )
        
        // When
        await sut.fetchArticles()
        
        // Then
        #expect(sut.articles == articules)
        #expect(sut.isLoading == false)
    }
    
    @Test(
        arguments: [
            (APIClientError.noData, "No se pudo cargar la información. Intenta nuevamente."),
            (APIClientError.network(URLError(.notConnectedToInternet)), "No tienes conexión a internet.")
        ]
    )
    func fetchArticlesFailure(error: APIClientError, errorMessage: String?) async throws {
        // Given
        var mockUseCase = MockFetchArticlesUseCase()
        let mockFetchCityUseCase = MockFetchCityUseCase()
        mockUseCase.resultToReturn = .failure(error)
        
        let sut = DashboardViewModel(
            fetchArticlesUseCase: mockUseCase,
            fetchCityUseCase: mockFetchCityUseCase
        )
        
        // When
        await sut.fetchArticles()
    
        // Then
        #expect(sut.errorMessage == errorMessage)
        #expect(!(sut.errorMessage?.isEmpty ?? true))
        #expect(sut.isLoading == false)
        #expect(sut.isPresentingError)
    }
    
    @Test
    func dismissCleanErrorMessage() async throws {
        // Given
        let mockUseCase = MockFetchArticlesUseCase()
        let mockFetchCityUseCase = MockFetchCityUseCase()
        
        let sut = DashboardViewModel(
            fetchArticlesUseCase: mockUseCase,
            fetchCityUseCase: mockFetchCityUseCase
        )
        sut.errorMessage = "Test error message"
        sut.isPresentingError = true
        
        // When
        sut.dismissError()
        
        // Then
        #expect(sut.errorMessage == nil)
        #expect(!sut.isPresentingError)
    }
    
    @Test(
        arguments: [
            Result<String, Error>.success("Chicago"),
            Result<String, Error>.failure(NSError(domain: "", code: 0, userInfo: nil))
        ]
    )
    func validateFetchCity(city: Result<String, Error>) async throws {
        // Given
        let mockUseCase = MockFetchArticlesUseCase()
        let mockFetchCityUseCase = MockFetchCityUseCase()
        mockFetchCityUseCase.result = city
        
        let sut = DashboardViewModel(
            fetchArticlesUseCase: mockUseCase,
            fetchCityUseCase: mockFetchCityUseCase
        )
        
        // When
        await sut.fetchCity()
        
        // Then
        do {
            let returnedCity = try city.get()
            #expect(sut.city == returnedCity)
        } catch {
            #expect(sut.city == "Error obteniendo ubicación")
        }
    }
}
