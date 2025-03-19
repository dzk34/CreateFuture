//
//  NetworkService.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

enum APIConstants {
    static let host = "yj8ke8qonl.execute-api.eu-west-1.amazonaws.com"
    static let scheme = "https"
    static let authKey = "Bearer 754t!si@glcE2qmOFEcN"
}

public enum NetworkError: LocalizedError {
    case failedResponse
    case invalidUrl
    case invalidServerResponse

    public var customMessage: String {
        switch self {
        case .failedResponse:
            return "Error: Failed response"
        case .invalidUrl:
            return "Error: invalid URL"
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
