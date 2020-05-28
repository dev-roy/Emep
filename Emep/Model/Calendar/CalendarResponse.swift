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
    var appointmentDate: String {
        return DateUtil.isoToTimeString(isoTime: latestAppointmentDate)
    }
    let earliestAppointmentDate: Int
    let appointments: [Appointment]
}
