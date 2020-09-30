//
//  UIImage+Extensions.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}

enum AssetIdentifier: String {
    case like
    case liked
    case save
    case saved
}
