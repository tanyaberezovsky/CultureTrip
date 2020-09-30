//
//  Articles.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

struct ArticlesContainer: Codable {
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case articles = "data"
    }
}

extension ArticlesContainer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ArticlesContainer.self, from: data)
    }
}

struct Article: Codable {
    let metaData: MetaData?
    let id, title: String?
    let imageURL: String?
    var isSaved, isLiked: Bool?
    var likesCount: Int?
    let category: String?
    let author: Author?

    enum CodingKeys: String, CodingKey {
        case metaData, id, title
        case imageURL = "imageUrl"
        case isSaved, isLiked, likesCount, category, author
    }
}

extension Article {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Article.self, from: data)
    }
}

struct Author: Codable {
    let id, authorName: String?
    let authorAvatar: AuthorAvatar?
}

extension Author {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Author.self, from: data)
    }
}

struct AuthorAvatar: Codable {
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

extension AuthorAvatar {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AuthorAvatar.self, from: data)
    }
}

struct MetaData: Codable {
    let creationTime, updateTime: String?
}

extension MetaData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MetaData.self, from: data)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
