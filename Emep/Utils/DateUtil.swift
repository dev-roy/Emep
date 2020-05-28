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
    
    static let mediumDateNoTimeFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        return formater
    }()
    
    static func isoToDate(isoTime: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(isoTime))
    }
    
    static func isoToTimeString(isoTime: Int) -> String {
        let date = isoToDate(isoTime: isoTime)
        return mediumDateNoTimeFormatter.string(from: date)
    }
}
