//
//  Date+Extensions.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation
//let formate = Date().getFormattedDate(dateString: "2016-04-04T20:55:21.000Z")
extension Date {
    enum DateFormats: String {
        case long
        case short
        public var format: String {
               switch (self) {
               case .long:
                    return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
               case .short:
                    return "d MMM, yyyy"
               }
        }
    }
    
    func dateToString(toFormat: DateFormats = .short) -> String {
        let dateformatOutput = DateFormatter()
        dateformatOutput.dateFormat = toFormat.format
        return dateformatOutput.string(from: self)
    }
}
