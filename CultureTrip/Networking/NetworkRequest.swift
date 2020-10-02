//
//  NetworkRequest.swift
//  CultureTrip
//
//  Created by Tanya Berezovsky on 02/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

class NetworkRequest {
    private let session: URLSession
    private var dataTask: URLSessionDataTask?

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
   
    func fetch<ApiResource: Resource>(resource: ApiResource, completion: @escaping (NetworkResponse<ApiResource>) -> Void) {
        cleanState()
        dataTask = session.dataTask(with: resource.url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            if let error = error {
                return completion(.failure(.sessionError(error: error)))
            }
            guard let data = data else { return completion(.failure(.noDataProvided)) }
            guard let response = response  as? HTTPURLResponse else { return completion(.failure(.noHTTPURLResponse)) }
            
            if response.statusCode == 200 {
                do {
                  let results = try resource.model(data: data)
                    return completion(.success(results))
                } catch let parseError as NSError {
                    return completion(.failure(.parsingModel(error: parseError)))
                }
            } else {
                return completion(.failure(.statusCodeError(statusCode: response.statusCode)))
            }
        }
        dataTask?.resume()
    }
}
// MARK: - Private Methods
private extension NetworkRequest {
    func cleanState() {
         dataTask?.cancel()
    }
}
