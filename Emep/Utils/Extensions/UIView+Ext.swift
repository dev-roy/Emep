//
//  UIView+Ext.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import UIKit

extension UIView {
    func constrainToVerticalCenterAndLeading(leadingInset: CGFloat) {
        guard let parent = self.superview else {
            fatalError("View does not have a supperview. Can not apply constraints")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: leadingInset).isActive = true
    }

    func constraintToSize(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addToAndFill(parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }
}
