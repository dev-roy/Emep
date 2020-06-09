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
    
    private let containsColor = UIColor.lightGray
    private let selectedColor = UIColor.red
    
    private var focusView: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeStart = 0
        layer.strokeEnd = 1
        return layer
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var dayDate: String = ""
    private var hasAppointments = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    private func setUpLayout() {
        dateLabel.addToAndFill(parent: contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Handles rotation
        updatePath()
    }
    
    private func updatePath() {
        let centerBounds = bounds
        let arcCenter = CGPoint(x: centerBounds.midX, y: centerBounds.midY)
        let radius = min(centerBounds.width, centerBounds.height) * 0.8 / 2
        focusView.path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
    }
    
    func setUpFor(cellState: CellState) {
        dayDate = DateUtil.getTimeStringFrom(date: cellState.date)
        dateLabel.text = cellState.text
        isHidden = cellState.dateBelongsTo != .thisMonth
    }
    
    func set(selected: Bool) {
        isSelected = selected
        focusView.fillColor = selected ? selectedColor.cgColor : focusView.fillColor
        drawFocus()
    }
    
    func set(hasAppointments: Bool) {
        self.hasAppointments = hasAppointments
        focusView.fillColor = hasAppointments ? containsColor.cgColor : nil
    }
    
    func drawFocus() {
        if (isSelected || hasAppointments) && focusView.superlayer == nil {
            layer.insertSublayer(focusView, at: 0)
        } else if !isSelected && !hasAppointments {
            focusView.removeFromSuperlayer()
        }
    }
}
