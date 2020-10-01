//
//  NetworkServiceError.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
    case couldNotCreateURLRequest
    case noHTTPURLResponse
    case sessionError(error: Error)
    case statusCodeError(statusCode: Int)
    case noDataProvided
    case parsingModel(error: Error)
}
