//
//  DateUtilTest.swift
//  EmepTests
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import XCTest
@testable import Emep

class DateUtilTest: XCTestCase {
    func test_getDateFromEpoc() {
        let epoc = 1590518639
        let result = DateUtil.getDateFrom(epocTime: epoc)
        XCTAssert(result.distance(to: Date(timeIntervalSince1970: TimeInterval(epoc))).isEqual(to: 0))
    }

    func test_getYearFromEpoc() {
        let epoc = 1590518639
        let result = DateUtil.getYearFrom(epocTime: epoc)
        XCTAssertEqual(result, 2020, "The year was not the expected")
    }

    func test_getTimeStringFromEpoc() {
        let epoc = 1590518639
        let result = DateUtil.getTimeStringFrom(epocTime: epoc)
        XCTAssertEqual(result, "May 26, 2020", "The date string was not the expected")
    }
    
    func test_getTimeStringFromDate() {
        let date = Date(timeIntervalSince1970: 1590518639)
        let result = DateUtil.getTimeStringFrom(date: date)
        XCTAssertEqual(result, "May 26, 2020", "The date string was not the expected")
    }
}
