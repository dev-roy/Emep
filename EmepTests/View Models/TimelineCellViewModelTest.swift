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
    }

    func test_getTitle() {
        let model = Appointment(date: 1556714671, title: "Title", description: "Description", type: .checkup, isEditable: false)
        let viewModel = TimelineCellViewModel(model: model)
        let title = viewModel.getTitle()
        XCTAssertEqual(title.title, "May 1, 2019 - checkup")
        XCTAssertEqual(title.description, model.title)
    }
}
