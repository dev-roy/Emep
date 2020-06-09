//
//  DateUtilTest.swift
//  EmepTests
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import XCTest
@testable import Emep

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

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

    func test_getMonthsInBetween() {
        let startDate = Date(timeIntervalSince1970: 1578590246) // Jan 9 2020
        let endDate = Date(timeIntervalSince1970: 1591723046) // June 9 2020
        let result = DateUtil.getMonthsInBetween(startDate: startDate, endDate: endDate)
        XCTAssertEqual(result.count, 6, "The were no six months in the result")
        XCTAssertEqual(result[0].get(.month), 1, "First month is not January")
        XCTAssertEqual(result[5].get(.month), 6, "Last month is not June")
    }

    func test_getMonthsInBetween_edgeLimits() {
        let startDate = Date(timeIntervalSince1970: 1580475599) // Jan 31 2020
        let endDate = Date(timeIntervalSince1970: 1588337999) // Apr 31 2020
        let result = DateUtil.getMonthsInBetween(startDate: startDate, endDate: endDate)
        XCTAssertEqual(result.count, 4, "The were no four months in the result")
        XCTAssertEqual(result[0].get(.month), 1, "First month is not January")
        XCTAssertEqual(result[3].get(.month), 4, "Last month is not April")
    }

    func test_getMonthsInBetween_sameMonth() {
        let startDate = Date(timeIntervalSince1970: 1578920399) // Jan 13 2020
        let endDate = Date(timeIntervalSince1970: 1580475599) // Jan 31 2020
        let result = DateUtil.getMonthsInBetween(startDate: startDate, endDate: endDate)
        XCTAssertEqual(result.count, 1, "The were no months in the result")
    }
    
    func test_getMonthsInBetween_greaterStartDate() {
        let startDate = Date(timeIntervalSince1970: 1588337999) // Apr 31 2020
        let endDate = Date(timeIntervalSince1970: 1580475599) // Jan 31 2020
        let result = DateUtil.getMonthsInBetween(startDate: startDate, endDate: endDate)
        XCTAssertEqual(result.count, 0, "There should have been no entries")
    }
}
