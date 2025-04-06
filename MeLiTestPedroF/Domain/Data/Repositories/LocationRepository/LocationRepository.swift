//
//  LocationRepository.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

import Foundation

protocol LocationRepository {
    func fetchCity() async throws -> String
    
    func startRetryingFetchCity(maxRetries: Int, delay: TimeInterval) async throws -> String
}
