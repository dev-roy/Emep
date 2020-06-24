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
    var reloadCalendarHandler: (() -> Void)?
    var reloadTimelineHandler: (() -> Void)?
    var hideLoaderHandler: (() -> Void)?
    var scrollToDateHandler: ((Date) -> Void)?
    var displayAppointmentDataHandler: ((String, String) -> Void)?
    
    enum Modules: Int {
        case timeline, calendar, undefined
    }

    private var selectedDate: Date?
    private var calendarMonths: [Date]?
    
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

        if let reloadCalendarDates = reloadCalendarDatesHandler,
            let previousDate = previousDate {
            reloadCalendarDates([previousDate])
        }

        guard let displayAppointmentData = displayAppointmentDataHandler else { return }
        let dayKey = DateUtil.getTimeStringFrom(date: date)
        displayAppointmentData(dayKey, timelineViewModel.getAppointmentsDetailsForDate(dayString: dayKey))
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        guard let selectedDate = selectedDate else { return false }
        return selectedDate == date
    }
    
    func getHeaderTitleFor(indexPath: IndexPath) -> String {
        guard let calendarMonths = calendarMonths else { return "" }
        return DateUtil.getMonthAndYearStringFrom(date: calendarMonths[indexPath.section])
    }
    
    func downloadAppointments() {
        timelineViewModel.downloadAppointments { [weak self] in
            guard
                let self = self,
                let hideLoader = self.hideLoaderHandler,
                let reloadCalendar = self.reloadCalendarHandler,
                let reloadTimeline = self.reloadTimelineHandler,
                let presentTimeline = self.presentTimelineHandler,
                let scrollToDate = self.scrollToDateHandler
                else { return }
            let (start, end) = self.timelineViewModel.getAppointmentsTimeframe()
            self.calendarMonths = DateUtil.getMonthsInBetween(startDate: start, endDate: end)
            hideLoader()
            reloadCalendar()
            reloadTimeline()
            presentTimeline()
            scrollToDate(end)
        }
    }
}
