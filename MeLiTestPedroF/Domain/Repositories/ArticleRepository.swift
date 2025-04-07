//
//  ArticleRepository.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

protocol ArticleRepository {
    func fetchArticles(searchText: String?) async throws -> [Article]
}
