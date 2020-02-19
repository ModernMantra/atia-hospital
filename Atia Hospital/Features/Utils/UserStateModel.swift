//
//  UserStateModel.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum UserType {
    case admin
    case standard
}

class UserStateModel {
    
    /// Singleton instance
    static let shared = UserStateModel()
    
    /// Type of the user
    public fileprivate (set) var userType: UserType
    
    private init() {
        self.userType = .standard
    }
    
    func setUserType(_ newValue: UserType) {
        self.userType = newValue
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            let vc: LoginAndRegisterViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController()
            let navController = UINavigationController(rootViewController: vc)
            
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                window.rootViewController = navController
            }
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
    
}
