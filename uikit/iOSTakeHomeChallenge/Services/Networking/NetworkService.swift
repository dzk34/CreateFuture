//
//  NetworkService.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

public enum NetworkError: LocalizedError {
    case failedResponse
    case invalidUrl
    case invalidRequest
    case canNotParseData
    case invalidServerResponse

    public var customMessage: String {
        switch self {
        case .failedResponse:
            return "Error: Failed response"
        case .invalidUrl:
            return "Error: invalid URL"
        case .invalidRequest:
            return "Invalid request"
        case .canNotParseData:
            return "Error: cannot parse data"
        case .invalidServerResponse:
            return "Error: invalid server response"
        }
    }
}

enum HTTPStatusCode: Int {
    case success = 200
    case notFound = 404
    case unknown
}
