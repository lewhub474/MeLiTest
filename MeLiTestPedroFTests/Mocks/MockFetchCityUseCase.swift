//
//  MockFetchCityUseCase.swift
//  MeLiTestPedroF
//
//  Created by Ronald Ivan Ruiz Poveda on 6/04/25.
//

@testable import MeLiTestPedroF

final class MockFetchCityUseCase: UseCase {
    var result: Result<String, Error> = .success("")
    
    func execute(_ params: Any?) async -> Result<String, Error> {
        return result
    }
}
