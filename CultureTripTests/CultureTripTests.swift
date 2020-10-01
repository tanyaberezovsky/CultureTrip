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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
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
