//
//  FetchCityUseCase.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

struct FetchCityUseCase: UseCase {
    private let repository: LocationRepository
    
    init(repository: LocationRepository = DefaultLocationRepository()) {
        self.repository = repository
    }
    
    func execute(_ params: Any?) async -> Result<String, Error> {
        do {
            let response = try await repository.startRetryingFetchCity(maxRetries: 10, delay: 2)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
