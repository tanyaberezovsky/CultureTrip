//
//  DateFormatter+Extentions.swift
//  CultureTrip
//
//  Created by Tanya Berezovsky on 08/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let iso8601Full :DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}
