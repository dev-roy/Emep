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

    private var groupedYearAppointments: [Int: [TimelineCellViewModel]] = [:]
    private var groupedDayAppointments: [String: [TimelineCellViewModel]] = [:]
    private var years: [Int] = []
    
    func downloadAppointments(completion: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            let appointments = self.calendarResponse.appointments
            var timelineViewModels = appointments.toCellViewModels()
            self.groupedYearAppointments = timelineViewModels.groupByYear()
            self.years = self.groupedYearAppointments.getSortedKeys()
            self.groupedDayAppointments = timelineViewModels.groupByDayDate()
            completion()
        }
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
            else { return (startDate: Date(), endDate: Date()) }
        return (startDate: firstAppointment.getDate(), endDate: lastAppointment.getDate())
    }
    
    func doesDateCellHasAppointments(date: DateCell) -> Bool {
        guard let dateAppointments = groupedDayAppointments[date.dayDate] else { return false }
        return !dateAppointments.isEmpty
    }
    
    func getAppointmentsDetailsForDate(dayString: String) -> String {
        guard let appointments = groupedDayAppointments[dayString] else { return "" }
        return appointments.map { (cell: TimelineCellViewModel) -> String in
            return "•\(cell.getTitle().description)\n\(cell.getDescription())"
        }
        .joined(separator: "\n")
    }
}
