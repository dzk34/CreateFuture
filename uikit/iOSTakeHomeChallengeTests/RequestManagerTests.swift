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
        
        let first = data.characters.first
        let last = data.characters.last
        
        XCTAssertEqual(first?.name, "name1")

        XCTAssertEqual(last?.name, "name2")
    }
}
