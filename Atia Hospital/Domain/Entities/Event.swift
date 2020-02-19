//
//  Event.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import Firebase

struct Event {
    
    let ref: DatabaseReference?
    let doctorUID: String
    let doctorName: String
    let date: String
    let approved: Bool
    let userUID: String
    let userName: String
    
    init(doctorUID: String, date: String, approved: Bool, userUID: String, doctorName: String, userName: String) {
        self.ref = nil
        self.doctorUID = doctorUID
        self.date = date
        self.approved = approved
        self.userUID = userUID
        self.doctorName = doctorName
        self.userName = userName
    }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let doctorUID = value["doctorUID"] as? String,
        let date = value["date"] as? String,
        let approved = value["approved"] as? Bool,
        let userName = value["userName"] as? String,
        let doctorName = value["doctorName"] as? String,
        let userUID = value["userUID"] as? String else {
        return nil
      }
      
      self.ref = snapshot.ref
        self.doctorUID = doctorUID
        self.date = date
        self.approved = approved
        self.userUID = userUID
        self.userName = userName
        self.doctorName = doctorName
    }
    
    func toAnyObject() -> Any {
        return [
            "doctorUID": doctorUID,
            "date": date,
            "approved": approved,
            "userUID": userUID,
            "userName": userName,
            "doctorName": doctorName
        ]
    }
    
}
