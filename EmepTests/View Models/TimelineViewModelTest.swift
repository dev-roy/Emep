//
//  TimelineViewModelTest.swift
//  EmepTests
//
//  Created by Hugo Flores Perez on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import XCTest
@testable import Emep

class TimelineViewModelTest: XCTestCase {
    let viewModel = TimelineViewModel()
    func test_getNumberOfYears() {
        XCTAssertGreaterThan(viewModel.getNumberOfYears(), 0)
    }
}
