//
//  CharactersViewModelTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 25/03/2025.
//

import XCTest

@testable import iOSTakeHomeChallenge

final class CharactersViewModelTests: XCTestCase {
    var sut: CharactersViewModel!
    var dataParser: DataParserProtocol!
    var sessionMock: URLSessionProtocolMock!
    var requestManagerMock: RequestManagerMock!

    override func setUpWithError() throws {
        let character1 = Character(name: "name", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])
        let character2 = Character(name: "name2", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])
        let characterList = CharactersList(characters: [character1, character2])

        sessionMock = try XCTUnwrap(URLSessionProtocolMock(charactersList: characterList))
        dataParser = DataParser()
        requestManagerMock = RequestManagerMock()
        sut = CharactersViewModel()
        sut.requestManager = requestManagerMock
    }
    
    override func tearDownWithError() throws {
        sessionMock = nil
        sut = nil
        dataParser = nil
    }

    func test_performRequest_shouldReturnData() async throws {
        await sut.getCharacters()
        XCTAssertNotNil(sut.characters)
    }

    func test_performRequest_ReturnedDataContainsCharacters() async throws {
        await sut.getCharacters()
        XCTAssert(!sut.characters.isEmpty)
    }

    func test_products_shouldReturnListOfCharacters() async throws {
        let expectedCharacter1 = Character(name: "name", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])
        let expectedCharacter2 = Character(name: "name2", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])

        await sut.getCharacters()
        
        let fetchedProduct1 = try XCTUnwrap(sut.characters.first)
        let fetchedProduct2 = try XCTUnwrap(sut.characters.last)
        
        XCTAssertEqual(fetchedProduct1.name, expectedCharacter1.name)
        XCTAssertEqual(fetchedProduct2.name, expectedCharacter2.name)
    }
}
