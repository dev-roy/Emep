//
//  Array+Ext.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/9/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

extension Array where Element == TimelineCellViewModel {
    func groupByYear() -> [Int: [Element]] {
        Dictionary(grouping: self, by: { (viewModel: Element) in viewModel.year })
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
