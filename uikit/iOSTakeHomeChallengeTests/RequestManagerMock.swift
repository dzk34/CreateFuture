//
//  RequestManagerMock.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 24/03/2025.
//

import XCTest
@testable import iOSTakeHomeChallenge

class RequestManagerMock: RequestManagerProtocol {
    @Inject(\.apiManagerMock) var apiManager: APIManagerProtocol
    @Inject(\.dataParser) var dataParser: DataParserProtocol

    func fetch(_ request: RequestProtocol, completionHandler: @escaping (Result<[Character], NetworkError>) -> Void) {
        
    }
    
//    var dataParser: DataParserProtocol
//    let apiManager: APIManagerProtocol

//    init(apiManager: APIManagerProtocol, dataParser: DataParserProtocol) {
//        self.apiManager = apiManager
//        self.dataParser = dataParser
//    }

    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        print("dzk2")
        let data = try await apiManager.perform(request)
        let decoded: T = try dataParser.parse(data: data)
        return decoded
    }
}
