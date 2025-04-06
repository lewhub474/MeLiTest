//
//  RequestBuilder.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import Foundation

final class RequestBuilder {
    private var path: String = ""
    private var method: HTTPMethod = .get
    private var headers: [String: String] = [:]
    private var queryParameters: [String: String] = [:]
    private var body: Data?

    func setPath(_ path: String) -> Self {
        self.path = path
        return self
    }

    func setMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }

    @discardableResult func addHeader(key: String, value: String) -> Self {
        headers[key] = value
        return self
    }

    func addQueryParameter(key: String, value: String) -> Self {
        queryParameters[key] = value
        return self
    }

    func setJSONBody<T: Encodable>(_ encodable: T) -> Self {
        self.body = try? JSONEncoder().encode(encodable)
        addHeader(key: "Content-Type", value: "application/json")
        return self
    }

    func build(baseURL: URL) throws -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }

        if !queryParameters.isEmpty {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.cachePolicy = .reloadIgnoringLocalCacheData


        return request
    }
}
