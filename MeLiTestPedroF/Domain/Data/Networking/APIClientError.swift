//
//  APIClientError.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

enum APIClientError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingFailed(Error)
    case invalidResponse
    case serverError(statusCode: Int, data: Data?)
    case network(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL proporcionada no es válida."
        case .noData:
            return "No se recibió respuesta del servidor."
        case .decodingFailed(let error):
            return "Fallo al decodificar la respuesta: \(error.localizedDescription)"
        case .invalidResponse:
            return "La respuesta del servidor no es válida."
        case .serverError(let code, _):
            return "El servidor respondió con un error: código \(code)."
        case .network(let error):
            return "Error de red: \(error.localizedDescription)"
        }
    }
}
