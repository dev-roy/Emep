//
//  Appointment.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

struct Appointment: Codable {
    let date: Int
    let type, title, description: String
    let isEditable: Bool
}
