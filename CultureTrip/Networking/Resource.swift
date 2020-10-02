//
//  Resource.swift
//  CultureTrip
//
//  Created by Tanya Berezovsky on 02/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

protocol Resource {
    associatedtype Model: Codable
    var url: URL { get }
    func model(data: Data) throws -> Model
    //other properties or functions
}
