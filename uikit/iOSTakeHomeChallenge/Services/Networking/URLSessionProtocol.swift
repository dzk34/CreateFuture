//
//  URLSessionProtocol.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 24/03/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(
        from url: URL,
        delegate: (URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
