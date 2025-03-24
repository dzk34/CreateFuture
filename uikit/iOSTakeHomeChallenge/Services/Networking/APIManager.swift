//
//  APIManager.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 23/03/2025.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data
}

class APIManager: APIManagerProtocol {
    @Inject(\.urlSession) var urlSession: URLSession

    func perform(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HTTPStatusCode.success.rawValue else { throw NetworkError.invalidServerResponse }

        return data
    }
}
