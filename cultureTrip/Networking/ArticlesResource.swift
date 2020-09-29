//
//  ArticlesResource.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation


public enum ResourceError: Error {
    case parsingFailed
    case emptyObject
}

protocol Resource {
    var url: URL { get }
    //var fullPath: String { get }
}

public protocol ResourceType where Model: Decodable {
  associatedtype Model
}

struct ArticlesResource: Resource {
    //var fullPath: String { return Endpoints.article.fullPath }
    
    
    //typealias Model = ArticlesContainer
    
    var url: URL { return Endpoints.article.getURL }
    
    init() {
    }
    
//    public func model(from data: Data) throws -> Articles {
//        guard let model = Articles(data: data) else {
//            throw ResourceError.parsingFailed
//        }
//        return model
//    }
//
//    public func model(mappedFrom root: Articles) throws -> Articles {
//        return root
//    }
}

