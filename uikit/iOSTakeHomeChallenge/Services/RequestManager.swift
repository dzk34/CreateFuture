//
//  RequestManager.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

protocol RequestManagerProtocol {
    // closure based
    func fetch(_ request: RequestProtocol, completionHandler: @escaping (_ result: Result<[Character], NetworkError>) -> Void)
    
    // async/await based
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    @Inject(\.apiManager) var apiManager: APIManagerProtocol
    @Inject(\.dataParser) var dataParser: DataParserProtocol

    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        print("dzk3")
        let data = try await apiManager.perform(request)
        
        let decoded: T = try dataParser.parse(data: data)
        return decoded
    }

    func fetch(_ request: RequestProtocol, completionHandler: @escaping (_ result: Result<[Character], NetworkError>) -> Void) {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15

        do {
            let req = try request.createURLRequest()
            let task = URLSession(configuration: config)
                .dataTask(with: req, completionHandler: { data, response, error in
                    if error == nil,
                       let data = data,
                       let resultData = try? JSONDecoder().decode([Character].self, from: data) {
                        completionHandler(.success(resultData))
                    } else {
                        print(error.debugDescription)
                        completionHandler(.failure(.canNotParseData))
                    }
                })
            task.resume()
        } catch {
            print(error.localizedDescription.debugDescription)
        }
    }
}
