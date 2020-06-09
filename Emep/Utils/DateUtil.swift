//
//  DateUtil.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

final class DateUtil {
    private init() {}
    
    private static let mediumDateNoTimeFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        return formater
    }()
    
    static func getDateFrom(epocTime: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(epocTime))
    }
    
    static func getTimeStringFrom(epocTime: Int) -> String {
        let date = getDateFrom(epocTime: epocTime)
        return getTimeStringFrom(date: date)
    }
    
    static func getYearFrom(epocTime: Int) -> Int {
        let date = getDateFrom(epocTime: epocTime)
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    static func getTimeStringFrom(date: Date) -> String {
        return mediumDateNoTimeFormatter.string(from: date)
    }
}
