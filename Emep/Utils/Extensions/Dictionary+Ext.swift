//
//  Dictionary+Ext.swift
//  Emep
//
//  Created by Hugo Flores Perez on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

extension Dictionary where Key == Int {
    func getSortedKeys() -> [Int] {
        return self.map { $0.key }.sorted { $0 > $1 }
    }
}
