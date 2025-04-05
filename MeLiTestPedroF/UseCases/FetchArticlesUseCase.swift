//
//  FetchArticlesUseCase.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class FetchArticlesUseCase {
    private let provider: NetworkingProvider

    init(provider: NetworkingProvider = NetworkingProvider()) {
        self.provider = provider
    }

    func execute(searchText: String?, completion: @escaping (Result<[Article], Error>) -> Void) {
        provider.fetchArticles(searchText: searchText) { result in
            completion(result)
        }
    }
}
