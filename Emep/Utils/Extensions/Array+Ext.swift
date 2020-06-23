//
//  Array+Ext.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/9/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

extension Array where Element == TimelineCellViewModel {
    mutating func groupByYear() -> [Int: [Element]] {
        self.sort { (previous: TimelineCellViewModel, next: TimelineCellViewModel) -> Bool in
            previous.getDate() > next.getDate()
        }
        return Dictionary(grouping: self, by: { (viewModel: Element) in viewModel.year })
    }

    func groupByDayDate() -> [String: [Element]] {
        Dictionary(grouping: self, by: { (viewModel: Element) in viewModel.dateFormatted })
    }
}

extension Array where Element == Appointment {
    func toCellViewModels() -> [TimelineCellViewModel] {
        return self.map { TimelineCellViewModel(model: $0) }
    }
}
