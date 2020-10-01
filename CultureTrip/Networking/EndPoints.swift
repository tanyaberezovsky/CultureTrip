//
//  EndPoints.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 29/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

struct NetworkConfiguration {
    static let baseUrl = "https://cdn.theculturetrip.com"
}

public enum Endpoints {
    case article

    var path: String {
        switch self {
        case .article:
            return "/home-assignment/response.json"
        }
    }
    
    public var getURL: URL {
        URL(string: NetworkConfiguration.baseUrl)!.appendingPathComponent(self.path)
    }
}

