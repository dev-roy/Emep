//
//  DateCell.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/4/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import JTAppleCalendar
import UIKit

class DateCell: JTACDayCell {
    static let reuseIdentifier = "dateCell"
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    private func setUpLayout() {
        dateLabel.addToAndCenter(parent: contentView)
    }
    
    func setUpFor(cellState: CellState) {
        dateLabel.text = cellState.text
        isHidden = cellState.dateBelongsTo != .thisMonth
        backgroundColor = cellState.isSelected ? .red : .none
    }
    
    func selectCell() {
        isSelected = true
        backgroundColor = .red
    }
}
