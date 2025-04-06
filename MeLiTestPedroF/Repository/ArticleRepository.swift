//
//  ArticleRepository.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

protocol ArticleRepository {
    func fetchArticles(searchText: String?) async throws -> [Article]
}

final class DefaultArticleRepository: ArticleRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient = DefaultAPIClient(baseURL: URL(string: "https://api.spaceflightnewsapi.net/v4")!)) {
        self.apiClient = apiClient
    }

    func fetchArticles(searchText: String?) async throws -> [Article] {
        let builder = RequestBuilder()
            .setPath("articles/")
            .addQueryParameter(key: "limit", value: "20")

        if let search = searchText, !search.isEmpty {
            builder.addQueryParameter(key: "search", value: search)
        }

        return try await apiClient.send(builder, responseType: ArticleResponse.self).results
    }
}
