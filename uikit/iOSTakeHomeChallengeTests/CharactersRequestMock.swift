//
//  CharactersRequestMock.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 24/03/2025.
//

import Foundation

@testable import iOSTakeHomeChallenge

enum CharactersRequestMock: RequestProtocol {
    case charactersList

    var path: String {
        guard let path = Bundle.main.path(forResource: "characters", ofType: "json") else { return "" }
        return path
    }
    
    var headers: [String : String] {
        ["Authorization": "authKey"]
    }

    var requestType: RequestType {
        return .get
    }
}
