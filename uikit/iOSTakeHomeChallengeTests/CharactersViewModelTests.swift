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

    override func setUpWithError() throws {
        let character1 = Character(name: "name", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])
        let character2 = Character(name: "name2", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])
        let productList = CharactersList(characters: [character1, character2])

        dataParser = DataParser()
        sut = CharactersViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func test_performRequest_shouldReturnData() async throws {
        try await sut.getCharacters()
        XCTAssertNotNil(sut.characters)
    }

    func test_performRequest_ReturnedDataContainsCharacters() async throws {
        try await sut.getCharacters()
        XCTAssert(!sut.characters.isEmpty)
    }

    func test_products_shouldReturnListOfCharacters() async throws {
        try await sut.getCharacters()
        let character1 = Character(name: "name", gender: "gender", culture: "culture", born: "born", died: "died", aliases: [], tvSeries: ["Season 1", "Season 2"], playedBy: ["Actor 1", "Actor 2", "Actor 3"])
        let productList = CharactersList(characters: [character1])

    }
}
