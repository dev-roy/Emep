//
//  TimelineViewModel.swift
//  Emep
//
//  Created by Hugo Flores Perez on 5/27/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import TimelineTableViewCell
import Foundation

class TimelineViewModel {

    let dummyDataSruct: [Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]] = [
    0: [
        (TimelinePoint(), UIColor.black, "12:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Sun"),
        (TimelinePoint(), UIColor.black, "15:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Sun"),
        (TimelinePoint(color: UIColor.green, filled: true), UIColor.green, "16:30", "Lorem ipsum dolor sit ", "150 mins", ["Apple"], "Sun"),
        (TimelinePoint(), UIColor.clear, "19:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nil, nil, "Moon")
    ],
    1: [
        (TimelinePoint(), UIColor.lightGray, "08:30", "Lorem ipsum dolor sit amet, c.", "60 mins", nil, "Sun"),
        (TimelinePoint(), UIColor.lightGray, "09:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod te.", "30 mins", nil, "Sun"),
        (TimelinePoint(), UIColor.lightGray, "10:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labor.", "90 mins", nil, "Sun"),
        (TimelinePoint(), UIColor.lightGray, "11:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do e.", "60 mins", nil, "Sun"),
        (TimelinePoint(color: UIColor.red, filled: true), UIColor.red, "12:30", "Lorem ipsum dolor sit amet, consect", "30 mins", ["Apple", "Apple", "Apple", "Apple"], "Sun"),
        (TimelinePoint(color: UIColor.red, filled: true), UIColor.red, "13:00", "Lorem ipsum dolor sit amet, consectetu", "120 mins", ["Apple", "Apple", "Apple", "Apple", "Apple"], "Sun"),
        (TimelinePoint(color: UIColor.red, filled: true), UIColor.lightGray, "15:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, se.", "150 mins", ["Apple", "Apple"], "Sun"),
        (TimelinePoint(), UIColor.lightGray, "17:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod .", "60 mins", nil, "Sun"),
        (TimelinePoint(), UIColor.lightGray, "18:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod temp.", "60 mins", nil, "Moon"),
        (TimelinePoint(), UIColor.lightGray, "19:30", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod te.", "30 mins", nil, "Moon"),
        (TimelinePoint(), backColor: UIColor.clear, "20:00", "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor .", nil, nil, "Moon")
    ]]

    typealias TimelineFormat = [Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]]

    private let calendarResponse = CalendarResponse.loadDummyData()

    private let data: [Int: [Appointment]]!
    private let years: [Int]!

    init() {
        data = calendarResponse.groupAppointments()
        years = calendarResponse.getAppointmentsYears()
    }

    func getNumberOfYears() -> Int {
        return data.count
    }

    func getNumberOfAppointments(forSection section: Int) -> Int {
        return data[section]?.count ?? 0
    }

    func getAppointment(forIndexPath indexPath: IndexPath) -> Appointment {
        guard let appointments = data[indexPath.section] else {
            return Appointment(date: 0, type: "", title: "", description: "", isEditable: false)
        }
        return appointments[indexPath.row]
    }
}
