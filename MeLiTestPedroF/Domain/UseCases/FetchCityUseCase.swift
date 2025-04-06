//
//  FetchCityUseCase.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

struct FetchCityUseCase {
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> String {
        try await repository.startRetryingFetchCity(maxRetries: 10, delay: 2)
    }
}
