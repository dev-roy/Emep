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
                Appointment(date: 1560175145, title: "Broke my finger", description: "Playing basketball. Didn't had any infection", type: .fracture, isEditable: true),
                Appointment(date: 1591029630, title: "Weekly Checkup", description: "Weekly checkup at the doctor. Everything went well", type: .checkup, isEditable: true),
                Appointment(date: 1591202430, title: "Vaccine", description: "For tetanus", type: .vaccine, isEditable: true),
                Appointment(date: 1589388030, title: "Nose operation", description: "It was too big", type: .operation, isEditable: true),
                Appointment(date: 1580662060, title: "Undefined", description: "Undefined", type: .undefined, isEditable: true)
        ])
    }
}
