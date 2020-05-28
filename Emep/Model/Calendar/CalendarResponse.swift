//
//  CalendarResponse.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

struct CalendarResponse: Codable {
    let canCreateAppointments: Bool
    let latestAppointmentDate: Int
    let earliestAppointmentDate: Int
    let appointments: [Appointment]
}

extension CalendarResponse {
    static func loadDummyData() -> CalendarResponse {
        return CalendarResponse(
            canCreateAppointments: true,
            latestAppointmentDate: 1590518639,
            earliestAppointmentDate: 1430505839,
            appointments: [
                Appointment(date: 1590512639, type: "", title: "A title", description: "A description", isEditable: true)
        ])
    }
    
    func getAppointmentsYears() -> [Int] {
        let yearGrouped = Dictionary(grouping: appointments) { $0.year }
        return Array(yearGrouped.keys).sorted(by: { $0 < $1 })
    }

    func groupAppointments() -> [Int: [Appointment]] {
        let yearGrouped = Dictionary(grouping: appointments) { $0.year }
        var yearIndexGrouped: [Int: [Appointment]] = [:]
        Array(yearGrouped.keys)
            .sorted(by: { $0 < $1 })
            .enumerated()
            .forEach { (index, key) in
            yearIndexGrouped[index] = yearGrouped[key]
        }
        return yearIndexGrouped
    }
}
