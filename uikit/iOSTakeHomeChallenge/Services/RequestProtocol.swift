//
//  RequestProtocol.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var headers: [String: String] { get }
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var scheme: String {
        APIConstants.scheme
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        guard let url = components.url
        else { throw NetworkError.invalidUrl }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

          if !headers.isEmpty {
              urlRequest.allHTTPHeaderFields = headers
          }
        
        return urlRequest
    }
}

enum RequestType: String {
    case get
    case post
    case put
    case patch
    case delete
}
