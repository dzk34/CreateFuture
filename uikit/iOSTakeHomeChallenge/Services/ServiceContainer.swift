//
//  ServiceContainer.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

private struct CharactersViewModelKey: InjectedServiceKey {
    static var currentValue: CharactersViewModel = CharactersViewModel()
}

private struct RequestManagerKey: InjectedServiceKey {
    static var currentValue: RequestManagerProtocol = RequestManager()
}

extension InjectedServiceValues {
    var charactersViewModel: CharactersViewModel {
        get { Self[CharactersViewModelKey.self] }
        set { Self[CharactersViewModelKey.self] = newValue }
    }
    
    var requestManager: RequestManagerProtocol {
        get { Self[RequestManagerKey.self] }
        set { Self[RequestManagerKey.self] = newValue }
    }
}
