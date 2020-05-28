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
    
    func test_groupAppointmentsByYearIndex() {
        let testData = CalendarResponse(
            canCreateAppointments: false,
            latestAppointmentDate: 1,
            earliestAppointmentDate: 1,
            appointments: [
                Appointment(date: 315685006, type: "", title: "", description: "", isEditable: true),
                Appointment(date: 1590603406, type: "", title: "", description: "", isEditable: true),
                Appointment(date: 1577902606, type: "", title: "", description: "", isEditable: true),
                Appointment(date: 1609525006, type: "", title: "", description: "", isEditable: true),
                Appointment(date: 1609611406, type: "", title: "", description: "", isEditable: true)
        ])
        let result = testData.groupAppointments()
        XCTAssertEqual(result.count, 3)
        guard let firstArray = result[0] else {
            XCTFail("Element does not exist")
            return
        }
        XCTAssertEqual(firstArray.count, 1)
        XCTAssertEqual(firstArray[0].date, testData.appointments[0].date)
        guard let secondArray = result[1] else {
            XCTFail("Element does not exist")
            return
        }
        XCTAssertEqual(secondArray.count, 2)
        guard let thirdArray = result[2] else {
            XCTFail("Element does not exist")
            return
        }
        XCTAssertEqual(thirdArray.count, 2)
    }
}
