//
//  DateHeader.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/9/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import JTAppleCalendar
import UIKit

class DateHeader: JTACMonthReusableView {
    static let reuseIdentifier = "DateHeader"
    @IBOutlet weak var headerLabel: UILabel!
}
