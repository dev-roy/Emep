//
//  Appointment.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

enum AppointmentType: String, Codable {
    case fracture
    case checkup
    case vaccine
    case operation
    case undefined

    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.undefined
    }
}

struct Appointment: Codable {
    let date: Int
    let title, description: String
    let type: AppointmentType
    let isEditable: Bool
    var year: Int { DateUtil.getYearFrom(epocTime: date) }
}
