//
//  ArticlesResource.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

struct ArticlesResource: Resource {
    typealias Model = ArticlesContainer
    var url: URL { return Endpoints.article.getURL }
    func model(data: Data) throws -> ArticlesContainer {
       // return try ArticlesContainer(data: data)
       
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)

        let plan = try! decoder.decode(ArticlesContainer.self, from: data)
       return plan
        // return try newJSONDecoder().decode(ArticlesContainer.self, from: data)
    }
}

