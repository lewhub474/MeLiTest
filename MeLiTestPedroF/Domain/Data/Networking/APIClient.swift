//
//  APIClient.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

protocol APIClient {
    func send<T: Decodable>(_ builder: RequestBuilder, responseType: T.Type) async throws -> T
}

final class DefaultAPIClient: APIClient {
    // MARK: - Constants
    private let successStatusCodes = 200..<300
    
    // MARK: - Variables
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func send<T: Decodable>(_ builder: RequestBuilder, responseType: T.Type) async throws -> T {
        let request: URLRequest
        
        do {
            request = try builder.build(baseURL: baseURL)
        } catch {
            throw APIClientError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw APIClientError.network(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIClientError.invalidResponse
        }
        
        guard successStatusCodes ~= httpResponse.statusCode else {
            throw APIClientError.serverError(statusCode: httpResponse.statusCode, data: data)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIClientError.decodingFailed(error)
        }
    }
}
