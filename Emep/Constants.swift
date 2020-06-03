//
//  Constants.swift
//  Emep
//
//  Created by chandrasekhar yadavally on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

enum Constants {
    static let DBREF = Database.database().reference()
    static let USERREF = DBREF.child("users")
    static let STORAGEREF = Storage.storage().reference()
}

