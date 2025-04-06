//
//  FetchArticlesUseCaseProtocol.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

protocol FetchArticlesUseCaseProtocol {
    func execute(_ params: String?) async throws -> Result<[Article], Error>
}
