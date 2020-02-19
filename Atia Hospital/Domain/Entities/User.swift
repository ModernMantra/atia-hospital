//
//  User.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "email": email
        ]
    }
    
}
