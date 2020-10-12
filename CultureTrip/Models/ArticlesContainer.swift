//
//  Articles.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

struct ArticlesContainer: Codable {
    let articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case articles = "data"
    }
}

struct Article: Codable {
    
    let id: String
    let metaData: MetaData
    let title: String
    let imageURL: String
    var isSaved, isLiked: Bool
    var likesCount: Int
    let category: String
    let author: Author

    enum CodingKeys: String, CodingKey {
        case metaData, id, title
        case imageURL = "imageUrl"
        case isSaved, isLiked, likesCount, category, author
    }
}

struct MetaData: Codable {
    let creationTime, updateTime: Date
}

struct Author: Codable {
    let id: String
    let authorName: String
    let authorAvatar: AuthorAvatar
}

struct AuthorAvatar: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}


