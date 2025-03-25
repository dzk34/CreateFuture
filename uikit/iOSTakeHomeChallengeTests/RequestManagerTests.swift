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
    
    override func setUp() {
        super.setUp()
    }
    
    func testRequestCharacters() async throws {
        guard let data: CharactersList = try await requestManager.perform(CharactersRequestMock.charactersList)
        else {
            XCTFail("Failed to get data from the request manager")
            return
        }
        
        let first = data.charactersList.first
        let last = data.charactersList.last
        
        XCTAssertEqual(first?.name, "Eddard Stark")

        XCTAssertEqual(last?.name, "Catelyn Stark")
    }
}
