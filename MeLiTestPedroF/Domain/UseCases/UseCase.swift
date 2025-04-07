//
//  UseCaseProtocol.swift
//  MeLiTestPedroF
//
//  Created by Macky on 6/04/25.
//

protocol UseCase<Params, Response> {
    associatedtype Params
    associatedtype Response

    func execute(_ params: Params) async -> Result<Response, any Error>
}
