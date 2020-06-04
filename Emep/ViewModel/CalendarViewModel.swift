//
//  CalendarViewModel.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/4/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import UIKit

class CalendarViewModel {
    let timelineViewModel = TimelineViewModel()
    
    var presentTimelineHandler: (() -> Void)?
    var presentCalendarHandler: (() -> Void)?
    
    enum Modules: Int {
        case timeline, calendar, undefined
    }
    
    func onSegmentedControlChanged(input: Int) {
        guard
            let presentTimeline = presentTimelineHandler,
            let presentCalendar = presentCalendarHandler
            else { return }
        let selectedModule = Modules.init(rawValue: input) ?? .undefined
        switch selectedModule {
        case .timeline: presentTimeline()
        case .calendar: presentCalendar()
        case .undefined: print("Undefined case")
        }
    }
}
