//
//  Articles.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

// MARK: - Articles
struct ArticlesContainer: Codable {
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case articles = "data"
    }
}

// MARK: Articles convenience initializers and mutators

extension ArticlesContainer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ArticlesContainer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        articles: [Article]
    ) -> ArticlesContainer {
        return ArticlesContainer(
            articles: articles
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Article
struct Article: Codable {
    let metaData: MetaData?
    let id, title: String?
    let imageURL: String?
    let isSaved, isLiked: Bool?
    let likesCount: Int?
    let category: String?
    let author: Author?

    enum CodingKeys: String, CodingKey {
        case metaData, id, title
        case imageURL = "imageUrl"
        case isSaved, isLiked, likesCount, category, author
    }
}

// MARK: Article convenience initializers and mutators

extension Article {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Article.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        metaData: MetaData?? = nil,
        id: String?? = nil,
        title: String?? = nil,
        imageURL: String?? = nil,
        isSaved: Bool?? = nil,
        isLiked: Bool?? = nil,
        likesCount: Int?? = nil,
        category: String?? = nil,
        author: Author?? = nil
    ) -> Article {
        return Article(
            metaData: metaData ?? self.metaData,
            id: id ?? self.id,
            title: title ?? self.title,
            imageURL: imageURL ?? self.imageURL,
            isSaved: isSaved ?? self.isSaved,
            isLiked: isLiked ?? self.isLiked,
            likesCount: likesCount ?? self.likesCount,
            category: category ?? self.category,
            author: author ?? self.author
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Author
struct Author: Codable {
    let id, authorName: String?
    let authorAvatar: AuthorAvatar?
}

// MARK: Author convenience initializers and mutators

extension Author {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Author.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        authorName: String?? = nil,
        authorAvatar: AuthorAvatar?? = nil
    ) -> Author {
        return Author(
            id: id ?? self.id,
            authorName: authorName ?? self.authorName,
            authorAvatar: authorAvatar ?? self.authorAvatar
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AuthorAvatar
struct AuthorAvatar: Codable {
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

// MARK: AuthorAvatar convenience initializers and mutators

extension AuthorAvatar {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AuthorAvatar.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        imageURL: String?? = nil
    ) -> AuthorAvatar {
        return AuthorAvatar(
            imageURL: imageURL ?? self.imageURL
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let creationTime, updateTime: String?
}

// MARK: MetaData convenience initializers and mutators

extension MetaData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MetaData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        creationTime: String?? = nil,
        updateTime: String?? = nil
    ) -> MetaData {
        return MetaData(
            creationTime: creationTime ?? self.creationTime,
            updateTime: updateTime ?? self.updateTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

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
