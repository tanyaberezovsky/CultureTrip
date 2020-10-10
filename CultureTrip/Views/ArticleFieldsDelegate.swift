//
//  ArticleFieldsDelegate.swift
//  CultureTrip
//
//  Created by Tanya Berezovsky on 05/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

protocol ArticleFieldsDelegate: class {
    func likeField(isLiked: Bool, likesCount: Int, row: Int)
    func saveField(isSaved: Bool, row: Int)
}
