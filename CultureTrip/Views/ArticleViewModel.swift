//
//  ArticelViewModel.swift
//  CultureTrip
//
//  Created by Tanya Berezovsky on 07/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit
protocol ArticleViewModelProtocol {
    var title: String { get set }
    var isSaved: Bool { get set }
    var isLiked: Bool { get set }
    var likesCount: Int { get set }
    var category: String { get set }
    var authorName: String { get set }
    var updateTime: String { get set }
    var articleImageUrl: String { get set }
    var avatarImageUrl: String { get set }
}
struct ArticleViewModel: ArticleViewModelProtocol {
    var title: String
    var isSaved: Bool
    var isLiked: Bool
    var likesCount: Int
    var category: String
    var authorName: String
    var updateTime: String
    var articleImageUrl: String
    var avatarImageUrl: String
 
    init(fromArticle article: Article) {
        title = article.title ?? ""
        isLiked = article.isLiked ?? false
        isSaved = article.isSaved ?? false
        likesCount = article.likesCount ?? 0
        category = article.category ?? ""
        authorName = article.author?.authorName ?? ""
        updateTime = article.metaData?.updateTime?.dateToString() ?? ""
        articleImageUrl = article.imageURL ?? ""
        avatarImageUrl = article.author?.authorAvatar?.imageURL ?? ""
    }
}
