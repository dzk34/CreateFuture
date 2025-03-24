//
//  RequestManagerTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 24/03/2025.
//

import XCTest

@testable import iOSTakeHomeChallenge

final class RequestManagerTests: XCTestCase {
    @Inject(\.requestManagerMock) var requestManager: RequestManagerProtocol

//    private var requestManager: RequestManagerMock?
    
    override func setUp() {
        super.setUp()
//        requestManager = RequestManagerMock(apiManager: APIManagerMock(), dataParser: DataParser())
    }
    
    func testRequestCharacters() async throws {
        print("dzk")
        guard let charactersList: [Character] = try await requestManager.perform(CharactersRequestProtocol.charactersList)
        else {
            XCTFail("Failed to get data from the request manager")
            return
        }
        
        let first = charactersList.first
        let last = charactersList.last

        XCTAssertEqual(first?.name, "Eddard Stark")

        XCTAssertEqual(last?.name, "Catelyn Stark")
    }
}
