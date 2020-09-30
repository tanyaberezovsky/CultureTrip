//
//  ArticlesResource.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

protocol Resource {
    var url: URL { get }
}

struct ArticlesResource: Resource {
    var url: URL { return Endpoints.article.getURL }
}

