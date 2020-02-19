//
//  Doctor.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

struct Doctor {
    
    let email: String
    let firstName: String
    let lastName: String
    let uid: String
    
    init(
        email: String,
        firstName: String,
        lastName: String,
        uid: String
    ) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.uid = uid
    }
    
    func toAnyObject() -> Any {
      return [
        "email": self.email,
        "firstName": self.firstName,
        "lastName": self.lastName,
        "uid": self.uid
      ]
    }
    
}
