//
//  TimelineCellViewModel.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/29/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

class TimelineCellViewModel {
    private let appointment: Appointment
    let year: Int
    let dateFormatted: String

    var isTop = false
    var isBottom = false

    init(model: Appointment) {
        self.appointment = model
        year = DateUtil.getYearFrom(epocTime: appointment.date)
        dateFormatted = DateUtil.getTimeStringFrom(epocTime: appointment.date)
    }
    
    func setCellLocation(cellIndex: Int, numberOfAppointments: Int) {
        isTop = cellIndex == 0
        isBottom = cellIndex == numberOfAppointments - 1
    }
    
    func getTitle() -> (title: String, description: String) {
        (title: "\(dateFormatted) - \(appointment.type.rawValue)", description: appointment.title)
    }
    
    func getAppointmentType() -> AppointmentType { appointment.type }
    
    func getDate() -> Date { DateUtil.getDateFrom(epocTime: appointment.date) }
    
    func getDescription() -> String { appointment.description }
}
