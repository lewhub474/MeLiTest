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
