//
//  User.swift
//  Emep
//
//  Created by chandrasekhar yadavally on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation

struct User {
    var name: String?
    var username: String?
    var email: String?
    var uid: String
    
    init(uid: String, dictionary: Dictionary<String?, Any>) {
        self.uid = uid
        if let name = dictionary["name"] { self.name = name as? String }
        if let username = dictionary["username"] { self.username = username as? String }
        if let email = dictionary["email"] { self.email = email as? String }
    }
    
}
