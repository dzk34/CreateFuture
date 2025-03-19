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

enum RequestType: String {
    case get
    case post
    case put
    case patch
    case delete
}
