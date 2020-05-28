//
//  DateUtil.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

final class DateUtil: NSObject {
    private static let isoDateFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formater
    }()
    
    private static let mediumDateNoTimeFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        return formater
    }()
    
    static func epocToDate(_ epocTime: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(epocTime))
    }
    
    static func epocToTimeString(_ epocTime: Int) -> String {
        let date = epocToDate(epocTime)
        return mediumDateNoTimeFormatter.string(from: date)
    }
    
    static func getYearFromEpoc(_ epocTime: Int) -> Int {
        let date = epocToDate(epocTime)
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
}
