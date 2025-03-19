//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

protocol CharactersViewModelProtocol {
    func getCharacters()
}

class CharactersViewModel {
    @Inject(\.requestManager) var requestManager: RequestManagerProtocol
    var characters: [Character] = []

    func getCharacters() {
        let requestData = CharactersRequestProtocol.charactersList
        requestManager.fetch(requestData) { result in
            print("dzk result \(result)")
        }
    }
}
