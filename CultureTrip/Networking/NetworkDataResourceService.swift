//
//  NetworkDataResourceService.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

class NetworkDataResourceService {
    private let session: URLSession
    private var dataTask: URLSessionDataTask?

    init(session: URLSession = URLSession.shared) {
          self.session = session
    }
   
    func fetch(resource: Resource, completion: @escaping (NetworkResponse) -> Void) {
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
                return completion(.success(data))
            } else {
                return completion(.failure(.statusCodeError(statusCode: response.statusCode)))
            }
        }
        dataTask?.resume()
    }
}
// MARK: - Private Methods
private extension NetworkDataResourceService {
    func cleanState() {
         dataTask?.cancel()
    }
}
