//
//  NetworkResourseLoader.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

class NetworkResourseLoader {
    private var service: NetworkDataResourceService
    
    public init(service: NetworkDataResourceService = NetworkDataResourceService()) {
        self.service = service
    }
  
    func getArticles(resource: Resource, completion: @escaping (NetworkResponse) -> Void) {

        service.fetch(resource: resource) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data as? Data else {
                    return completion(.failure(.noDataProvided))
                }
                
                do {
                    let articles = try self?.serializeArticles(data)
                    completion(.success(articles))                    
                } catch let error {
                    completion(.failure(.parsingModel(error: error)))
                }
            case .failure(let networkServiceError):
                completion(.failure(networkServiceError))
            }
            
        }
    }
}

// MARK: - Private Methods
private extension NetworkResourseLoader {
    
    func serializeArticles(_ data: Data) throws -> [Article] {
      var articles: [Article]
      
      do {
        articles = try ArticlesContainer(data: data).articles
      } catch let parseError as NSError {
        throw parseError
      }
      return articles
    }
  }
  
