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

    private let groupedYearAppointments: [Int: [TimelineCellViewModel]]
    private let groupedDayAppointments: [String: [TimelineCellViewModel]]
    private let years: [Int]

    init() {
        let appointments = calendarResponse.appointments
        let timelineViewModels = appointments.toCellViewModels()
        groupedYearAppointments = timelineViewModels.groupByYear()
        years = groupedYearAppointments.getSortedKeys()
        groupedDayAppointments = timelineViewModels.groupByDayDate()
    }

    func getNumberOfYears() -> Int {
        return groupedYearAppointments.count
    }
    
    func getHeaderStringForSection(_ section: Int) -> String {
        return "\(years[section])"
    }

    func getNumberOfAppointments(forSection section: Int) -> Int {
        let year = years[section]
        return groupedYearAppointments[year]?.count ?? 0
    }

    func getAppointment(forIndexPath indexPath: IndexPath) -> TimelineCellViewModel {
        let year = years[indexPath.section]
        guard let appointments = groupedYearAppointments[year] else {
            fatalError("No appointments array for year")
        }
        let cellViewModel = appointments[indexPath.row]
        cellViewModel.setCellLocation(cellIndex: indexPath.row, numberOfAppointments: appointments.count)
        return cellViewModel
    }
    
    func getAppointmentsTimeframe() -> (startDate: Date, endDate: Date) {
        guard
            let firstYear = years.last,
            let lastYear = years.first,
            let firstAppointment = groupedYearAppointments[firstYear]?.last,
            let lastAppointment = groupedYearAppointments[lastYear]?.first
            else { fatalError("No appointments array for year") }
        return (startDate: firstAppointment.getDate(), endDate: lastAppointment.getDate())
    }
    
    func doesDateCellHasAppointments(date: DateCell) -> Bool {
        guard let dateAppointments = groupedDayAppointments[date.dayDate] else { return false }
        return !dateAppointments.isEmpty
    }
}
