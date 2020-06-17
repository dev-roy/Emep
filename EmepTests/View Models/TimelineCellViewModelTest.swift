//
//  TimelineCellViewModelTest.swift
//  EmepTests
//
//  Created by Hugo Flores Perez on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import XCTest
@testable import Emep

class TimelineCellViewModelTest: XCTestCase {
    func test_modelYearParse() {
        let model = Appointment(date: 1556714671, title: "Title", description: "Description", type: .checkup, isEditable: false)
        let viewModel = TimelineCellViewModel(model: model)
        XCTAssertEqual(viewModel.year, 2019)
        XCTAssertEqual(viewModel.dateFormatted, "May 1, 2019")
    }

    func test_getTitle() {
        let model = Appointment(date: 1556714671, title: "Title", description: "Description", type: .checkup, isEditable: false)
        let viewModel = TimelineCellViewModel(model: model)
        let title = viewModel.getTitle()
        XCTAssertEqual(title.title, "May 1, 2019 - checkup")
        XCTAssertEqual(title.description, model.title)
    }

    func test_groupByYear() {
        let models = [
            Appointment(date: 1556714671, title: "Title", description: "Description", type: .checkup, isEditable: false),
            Appointment(date: 1560083909, title: "Title", description: "Description", type: .checkup, isEditable: false),
            Appointment(date: 1591706309, title: "Title", description: "Description", type: .checkup, isEditable: false)
        ]
        let yearDictionary = models.toCellViewModels().groupByYear()
        guard let firstGroup = yearDictionary[2020] else {
            XCTFail("No entries for year 2020")
            return
        }
        XCTAssertEqual(firstGroup.count, 1)
        guard let secondGroup = yearDictionary[2019] else {
            XCTFail("No entries for year 2019")
            return
        }
        XCTAssertEqual(secondGroup.count, 2)
    }
    
    func test_groupByDayDate() {
        let models = [
            Appointment(date: 1556714671, title: "Title", description: "Description", type: .checkup, isEditable: false),
            Appointment(date: 1591706309, title: "Title", description: "Description", type: .checkup, isEditable: false),
            Appointment(date: 1591706300, title: "Title", description: "Description", type: .checkup, isEditable: false),
            Appointment(date: 1591619909, title: "Title", description: "Description", type: .checkup, isEditable: false)
        ]
        let dayDateDictionary = models.toCellViewModels().groupByDayDate()
        guard let firstGroup = dayDateDictionary["May 1, 2019"] else {
            XCTFail("No entries for date May 1, 2019")
            return
        }
        XCTAssertEqual(firstGroup.count, 1)
        guard let secondGroup = dayDateDictionary["Jun 9, 2020"] else {
            XCTFail("No entries for date Jun 9, 2020")
            return
        }
        XCTAssertEqual(secondGroup.count, 2)
        guard let thirdGroup = dayDateDictionary["Jun 8, 2020"] else {
            XCTFail("No entries for date Jun 8, 2020")
            return
        }
        XCTAssertEqual(thirdGroup.count, 1)
    }
}
