//
//  Mock.swift
//  MeLiTestPedroFTests
//
//  Created by Macky on 6/04/25.
//

import Foundation
@testable import MeLiTestPedroF

final class MockFetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    var resultToReturn: Result<[Article], Error> = .success([])

    func execute(_ params: String?) async throws -> Result<[Article], Error> {
        return resultToReturn
    }
}
