//
//  RequestManager.swift
//  iOSTakeHomeChallenge
//
//  Created by Khaled on 19/03/2025.
//

import Foundation

protocol RequestManagerProtocol {
    func fetch(_ request: RequestProtocol, completionHandler: @escaping (_ result: Result<[Character], NetworkError>) -> Void)
}

class RequestManager: RequestManagerProtocol {
    
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
