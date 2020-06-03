//
//  TimelineViewModel.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import TimelineTableViewCell
import Foundation

class TimelineViewModel {
    typealias TimelineFormat = [Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]]

    private let calendarResponse = CalendarResponse.loadDummyData()

    private let groupedAppointments: [Int: [TimelineCellViewModel]]!
    private let years: [Int]!

    init() {
        let timelineViewModels = calendarResponse.appointments.map { TimelineCellViewModel(model: $0) }
        groupedAppointments = timelineViewModels.groupByYear()
        years = groupedAppointments.getSortedKeys()
    }

    func getNumberOfYears() -> Int {
        return groupedAppointments.count
    }
    
    func getHeaderStringForSection(_ section: Int) -> String {
        return "\(years[section])"
    }

    func getNumberOfAppointments(forSection section: Int) -> Int {
        let year = years[section]
        return groupedAppointments[year]?.count ?? 0
    }

    func getAppointment(forIndexPath indexPath: IndexPath) -> TimelineCellViewModel {
        let year = years[indexPath.section]
        guard let appointments = groupedAppointments[year] else {
            fatalError("No appointments array for year")
        }
        let cellViewModel = appointments[indexPath.row]
        cellViewModel.setCellLocation(cellIndex: indexPath.row, numberOfAppointments: appointments.count)
        return cellViewModel
    }
}
