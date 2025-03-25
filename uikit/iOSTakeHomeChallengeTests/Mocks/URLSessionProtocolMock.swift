//
//  URLSessionProtocolMock.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Khaled on 25/03/2025.
//

import Foundation

@testable import iOSTakeHomeChallenge

class URLSessionProtocolMock: URLSessionProtocol {
    let data: Data
    var dataURL: URL?
    
    init(data: Data) {
        self.data = data
    }
    
    func data(from url: URL, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        dataURL = url
        
        guard let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        else {
            fatalError() // it's ok to crash for now because it's a test, but in the real world we will do it properly later
        }
        
        return (data, response)
    }
    
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let url = request.url, let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        else {
            fatalError()
        }

        dataURL = url

        return (data, response)
    }
}

extension URLSessionProtocolMock {
    convenience init?(charactersList: CharactersList) {
        do {
            let data = try JSONEncoder().encode(charactersList)
            self.init(data: data)
        } catch {
            fatalError()
        }
    }
}
