//
//  CharactersViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation
import Combine

protocol CharactersViewModelProtocol {
    // async/await based
    func getCharacters() async

    // closure based
    func getCharactersClosureBased()
    
    func search(searchText: String)
}

class CharactersViewModel: ObservableObject, CharactersViewModelProtocol {
    @Inject(\.requestManager) var requestManager: RequestManagerProtocol
    @Published private(set) var characters: [Character] = []
    private var fetchedCharacters: [Character] = []

    func getCharacters() async {
        do {
            let requestData = CharactersRequestProtocol.charactersList
            let characters: [Character] = try await requestManager.perform(requestData)
            self.characters = characters
            self.fetchedCharacters = characters
        } catch {
            print(error)
        }
    }
    
    func getCharactersClosureBased() {
        let requestData = CharactersRequestProtocol.charactersList
        requestManager.fetch(requestData) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.fetchedCharacters = characters
            case .failure(let error):
                print("Fetching data failed with error \(error)")
            }
        }
    }
    
    func search(searchText: String) {
        if searchText == "" {
            characters = fetchedCharacters
        } else {
            characters = fetchedCharacters.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
}
