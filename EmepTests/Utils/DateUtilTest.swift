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
    func test_getYearFromEpoc() {
        let epoc = 1590518639
        let result = DateUtil.getYearFromEpoc(epoc)
        XCTAssertEqual(result, 2020, "The year was not the expected")
    }
}
