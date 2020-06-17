//
//  ViewController.swift
//  Emep
//
//  Created by Rodrigo Buendia Ramos on 5/20/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserNetworkManager.shared.signOut()
    }
    
//    createUser(email: "test1@test.com", password: "Welcome@100", name: "tester1", username: "testerusername1")
}
