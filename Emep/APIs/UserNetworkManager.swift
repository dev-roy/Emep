//
//  UserNetworkManager.swift
//  Emep
//
//  Created by chandrasekhar yadavally on 6/1/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

final class UserNetworkManager {
    static let shared = UserNetworkManager()
    
    func createUser(email: String, password: String, name: String, username: String) {
        DispatchQueue.global(qos: .background).async {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else { return }
                let dictionaryValues = [ "name": name,"username": username, "email": email ]
                let values = [result?.user.uid: dictionaryValues]
                
                Constants.USERREF.updateChildValues(values) { error, _ in
                    guard error == nil else { return }
                    print("Successfully created user")
                }
                
            }
        }
    }
    
    func signIn(email: String, password: String) {
        DispatchQueue.global(qos: .background).async {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    print("Unable to sign in")
                    return
                }
                print("signed in successfully")
            }
        }
    }
    
    func signOut() {
        DispatchQueue.global(qos: .background).async {
            do {
                try Auth.auth().signOut()
                print("User signed out successfully")
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
    }
}
