//
//  NetworkResourseLoader2.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

public enum NetworkServiceError2: Error {
    case couldNotCreateURLRequest
    case noHTTPURLResponse
    case sessionError(error: Error)
    case statusCodeError(statusCode: Int)
    case noDataProvided
    case parsingModel(error: Error)
}

public enum NetworkResponse2<Model> {
  case success(Model)
  case failure(NetworkServiceError2)
}


class NetworkResourseLoader2 {
    
   let defaultSession: URLSession
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    typealias QueryResult = ([Article]?, String) -> Void
  //  typealias ResourseResult = (NetworkResponse<Resource.Model>) -> Void
    
    init(session: URLSession = URLSession.shared) {
        self.defaultSession = session
    }
    func getArticles(resource: Resource, completion: @escaping QueryResult) {
        cleanState()
//        guard let urlComponents = URLComponents(string: resource.fullPath), let url = urlComponents.url else {
//            return
//        }
        print(resource.url.absoluteString)
        print(resource.url)
        dataTask = defaultSession.dataTask(with: resource.url) { [weak self] data, response, error in
//        defer {
//          self?.dataTask = nil
//        }
        
        if let error = error {
          self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
        } else if
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          let articles = self?.serializeArticles(data)
          
          DispatchQueue.main.async {
            completion(articles, self?.errorMessage ?? "")
          }
        }
      }
      dataTask?.resume()
    }
    
//    func getResourse(resource: Resource, completion: @escaping QueryResult) {
//           cleanState()
//
//           dataTask = defaultSession.dataTask(with: resource.url) { [weak self] data, response, error in
//           defer {
//             self?.dataTask = nil
//           }
//
//           if let error = error {
//             self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
//           } else if
//             let data = data,
//             let response = response as? HTTPURLResponse,
//             response.statusCode == 200 {
//             let articles = self?.serializeArticles(data)
//
//             DispatchQueue.main.async {
//               completion(articles, self?.errorMessage ?? "")
//             }
//           }
//         }
//         dataTask?.resume()
//       }
}


// MARK: - Private Methods
private extension NetworkResourseLoader2 {
    func cleanState() {
         dataTask?.cancel()
         errorMessage = ""
    }

    func serializeArticles(_ data: Data) -> [Article]? {
      var articles: [Article]
      
      do {
        articles = try ArticlesContainer(data: data).articles
      } catch let parseError as NSError {
        errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
        return nil
      }
      
      if articles.count == 0 {
        errorMessage += "Dictionary does not contain results key\n"
        return nil
      }
      
      return articles
    }
  }
  
