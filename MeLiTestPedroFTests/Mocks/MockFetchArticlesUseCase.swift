//
//  Mock.swift
//  MeLiTestPedroFTests
//
//  Created by Macky on 6/04/25.
//

import Foundation
@testable import MeLiTestPedroF

struct MockFetchArticlesUseCase: UseCase {
    var resultToReturn: Result<[Article], Error> = .success([])

    func execute(_ params: String?) async -> Result<[Article], Error> {
        return resultToReturn
    }
}
