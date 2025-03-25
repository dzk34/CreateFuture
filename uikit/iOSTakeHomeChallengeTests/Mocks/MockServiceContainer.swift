//
//  MockServiceContainer.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 24/03/2025.
//

import Foundation

@testable import iOSTakeHomeChallenge

private struct APIManagerMockKey: InjectedServiceKey {
    static var currentValue: APIManagerProtocol = APIManagerMock()
}

private struct RequestManagerMockKey: InjectedServiceKey {
    static var currentValue: RequestManagerProtocol = RequestManagerMock()
}


extension InjectedServiceValues {
    var apiManagerMock: APIManagerProtocol {
        get { Self[APIManagerMockKey.self] }
        set { Self[APIManagerMockKey.self] = newValue }
    }
    
    var requestManagerMock: RequestManagerProtocol {
        get { Self[RequestManagerMockKey.self] }
        set { Self[RequestManagerMockKey.self] = newValue }
    }
}
