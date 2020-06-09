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

    private static let monthAndYearFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "MMMM yyyy"
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

    static func getMonthsInBetween(startDate: Date, endDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = startDate
        while date <= endDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .month, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    static func getMonthAndYearStringFrom(date: Date) -> String {
        return monthAndYearFormatter.string(from: date)
    }
}
