//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation
import Combine

protocol CharactersViewModelProtocol {
    func getCharacters()
}

class CharactersViewModel: ObservableObject, CharactersViewModelProtocol {
    @Inject(\.requestManager) var requestManager: RequestManagerProtocol
    @Published private(set) var characters: [Character] = []
    
    func getCharacters() {
        let requestData = CharactersRequestProtocol.charactersList
        requestManager.fetch(requestData) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
            case .failure(let error):
                print(error)
            }
        }
    }
}
