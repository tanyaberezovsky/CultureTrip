//
//  CultureTripTests.swift
//  CultureTripTests
//
//  Created by Tanya Berezovsky on 01/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import XCTest
@testable import CultureTrip

class CultureTripTests: XCTestCase {
    
    func testDateFormatterOneDigit() {
        let formatedDate = Date().getFormattedDate(dateString: "2016-04-04T20:55:21.000Z")
        let expected = "4 Apr, 2016"
        XCTAssertEqual(formatedDate, expected)
    }
    
    func testDateFormatterTwoDigit() {
        let formatedDate = Date().getFormattedDate(dateString: "2016-04-25T20:55:21.000Z")
        let expected = "25 Apr, 2016"
        XCTAssertEqual(formatedDate, expected)
    }

}
