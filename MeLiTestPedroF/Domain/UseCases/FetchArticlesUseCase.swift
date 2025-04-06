//
//  FetchArticlesUseCase.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

final class FetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    private let repository: ArticleRepository

    init(repository: ArticleRepository = DefaultArticleRepository()) {
        self.repository = repository
    }

    func execute(_ params: String?) async throws -> Result<[Article], Error> {
        do {
            let articles = try await repository.fetchArticles(searchText: params)
            return .success(articles)
        } catch {
            return .failure(error)
        }
    }
}

