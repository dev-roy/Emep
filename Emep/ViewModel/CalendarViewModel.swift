//
//  CalendarViewModel.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/4/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

class CalendarViewModel {
    let timelineViewModel = TimelineViewModel()
    
    var presentTimelineHandler: (() -> Void)?
    var presentCalendarHandler: (() -> Void)?
    var reloadCalendarDatesHandler: (([Date]) -> Void)?
    
    enum Modules: Int {
        case timeline, calendar, undefined
    }

    private var selectedDate: Date?
    
    func onSegmentedControlChanged(input: Int) {
        guard
            let presentTimeline = presentTimelineHandler,
            let presentCalendar = presentCalendarHandler
            else { return }
        let selectedModule = Modules.init(rawValue: input) ?? .undefined
        switch selectedModule {
        case .timeline: presentTimeline()
        case .calendar: presentCalendar()
        case .undefined: fatalError("Unimplemented segmented control case for calendar")
        }
    }
    
    func setSelectedDate(_ date: Date) {
        let previousDate = selectedDate
        selectedDate = date
        if let handler = reloadCalendarDatesHandler,
            let previousDate = previousDate {
            handler([previousDate])
        }
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        guard let selectedDate = selectedDate else { return false }
        return selectedDate == date
    }
}
