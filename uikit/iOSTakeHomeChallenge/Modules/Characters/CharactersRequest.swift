//
//  CharactersRequest.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

enum CharactersRequestProtocol: RequestProtocol {
    case charactersList

    var path: String {
        "characters"
    }
    
    var headers: [String : String] {
        ["Authorization": APIConstants.authKey]
    }

    var requestType: RequestType {
        .get
    }
}
