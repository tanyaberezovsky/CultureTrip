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
    var articleImage: UIImage? { get set }
    var avatarImage: UIImage? { get set }
}
struct ArticleViewModel: ArticleViewModelProtocol {
    var title: String
    var isSaved: Bool
    var isLiked: Bool
    var likesCount: Int
    var category: String
    var authorName: String
    var updateTime: String
    var articleImage: UIImage?
    var avatarImage: UIImage?
 
    init(fromArticle article: Article, articleImage: UIImage?, avatarImage: UIImage?) {
        title = article.title
        isLiked = article.isLiked
        isSaved = article.isSaved
        likesCount = article.likesCount
        category = article.category
        authorName = article.author.authorName
        updateTime = article.metaData.updateTime.dateToString()
        if let articleImage = articleImage {
            self.articleImage = articleImage
        }        
        if let avatarImage = avatarImage {
            self.avatarImage = avatarImage
        }
    }
}
