//
//  MeLiTestPedroFTests.swift
//  MeLiTestPedroFTests
//
//  Created by Macky on 4/04/25.
//

import XCTest
@testable import MeLiTestPedroF

@MainActor
final class DashboardViewModelTests: XCTestCase {

    func test_fetchArticles_success() async {
        let mockUseCase = MockFetchArticlesUseCase()
        let expectedArticles = [Article(id: 1, title: "Title", summary: "Summary", image_url: "2025-01-01", url: "", published_at: "")]
        mockUseCase.resultToReturn = .success(expectedArticles)

        let viewModel = DashboardViewModel(fetchArticlesUseCase: mockUseCase)
        await viewModel.prepareAndFetchArticles()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Title")
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_fetchArticles_failure() async {
        let mockUseCase = MockFetchArticlesUseCase()
        mockUseCase.resultToReturn = .failure(URLError(.notConnectedToInternet))

        let viewModel = DashboardViewModel(fetchArticlesUseCase: mockUseCase)
        await viewModel.prepareAndFetchArticles()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.articles.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "No tienes conexión a internet.")
    }
}
