//
//  NetworkResponse.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

enum NetworkResponse<ApiResource: Resource> {
    case success(ApiResource.Model)
    case failure(NetworkServiceError)
}
