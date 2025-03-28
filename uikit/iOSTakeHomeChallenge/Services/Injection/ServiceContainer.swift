//
//  ServiceContainer.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

// MARK: Injected Services

private struct CharactersViewModelKey: InjectedServiceKey {
    static var currentValue: CharactersViewModel = CharactersViewModel()
}

private struct RequestManagerKey: InjectedServiceKey {
    static var currentValue: RequestManagerProtocol = RequestManager()
}

private struct DataParserKey: InjectedServiceKey {
    static var currentValue: DataParserProtocol = DataParser()
}

private struct APIManagerKey: InjectedServiceKey {
    static var currentValue: APIManagerProtocol = APIManager()
}

private struct URLSessionKey: InjectedServiceKey {
    static var currentValue: URLSessionProtocol = URLSession(configuration: .default)
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
    
    var dataParser: DataParserProtocol {
        get { Self[DataParserKey.self] }
        set { Self[DataParserKey.self] = newValue }
    }
    
    var apiManager: APIManagerProtocol {
        get { Self[APIManagerKey.self] }
        set { Self[APIManagerKey.self] = newValue }
    }
    
    var urlSession: URLSessionProtocol {
        get { Self[URLSessionKey.self] }
        set { Self[URLSessionKey.self] = newValue }
    }
}
