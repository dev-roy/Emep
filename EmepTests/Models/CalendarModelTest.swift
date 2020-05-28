//
//  CalendarModelTest.swift
//  EmepTests
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import XCTest
@testable import Emep

class CalendarModelTest: XCTestCase {

    func testJSONParsing() {
        let bundle = Bundle(for: type(of: self))
        let result: Result<CalendarResponse, JSONUtilError> = JSONUtil.loadJSON(forBunle: bundle, resourceName: "CalendarResponseModel")
        switch result {
        case .success:
            XCTAssert(true)
        case .failure(let error):
            XCTFail("The model did not parse the JSON successfully. \(error)")
        }
    }

    func testTransformedValues() {
        let bundle = Bundle(for: type(of: self))
        let result: Result<CalendarResponse, JSONUtilError> = JSONUtil.loadJSON(forBunle: bundle, resourceName: "CalendarResponseModel")
        switch result {
        case .success(let data):
            XCTAssertGreaterThan(data.latestAppointmentDate, 0)
            XCTAssertEqual("May 26, 2020", data.appointmentDate)
        case .failure(let error):
            XCTFail("The model did not parse the JSON successfully. \(error)")
        }
    }

    func testInvalidJSONHandling() {
        let bundle = Bundle(for: type(of: self))
        let result: Result<CalendarResponse, JSONUtilError> = JSONUtil.loadJSON(forBunle: bundle, resourceName: "InvalidJSON")
        switch result {
        case .success:
            XCTFail("JSON Parsing should have failed")
        case .failure(let error):
            switch error {
            case .jsonParsing:
                XCTAssert(true)
            default:
                XCTFail("The error should have been jsonParsing. \(error)")
            }
        }
    }
}
