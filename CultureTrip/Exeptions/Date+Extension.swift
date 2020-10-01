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
    
    func getFormattedDate(dateString: String?, from: DateFormats = .long, to: DateFormats = .short) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = from.format

        guard let dateString = dateString, let date = dateFormatterGet.date(from: dateString) else { return "" }
          
        let dateformatOutput = DateFormatter()
        dateformatOutput.dateFormat = to.format
        return dateformatOutput.string(from: date)
    }
}
