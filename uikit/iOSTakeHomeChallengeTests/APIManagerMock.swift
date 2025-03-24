//
//  APIManagerMock.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 24/03/2025.
//

import Foundation

@testable import iOSTakeHomeChallenge

struct APIManagerMock: APIManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data {
        return try JSONSerialization.data(withJSONObject: Character.examples, options: [.prettyPrinted])
        
//        return try jsonse
//        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }
}

