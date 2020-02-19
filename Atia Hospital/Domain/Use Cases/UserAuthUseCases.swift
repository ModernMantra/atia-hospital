//
//  UserAuthUseCases.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import Firebase

enum AuthError: Error {
    case noCurrentUser
}

/// Basic behaviour for the user authentication use cases, covering:
///   - user login
///   - user logout
///   - creating new user
protocol UserAuthUseCases {
    
    typealias UserAuthCompletion = (Result<User, Error>) -> Void
    
    /// Login existing user with given credentials
    /// Local validation is not necesary and would be handled on backend side.
    /// - Parameters:
    ///   - email: the email
    ///   - password: the password
    ///   - completion: completion handler with result containing the error or user
    func loginUser(email: String, password: String, completion: @escaping UserAuthCompletion)
    
    /// Create *new user* with given credentials
    /// - Parameters:
    ///   - email: the email for the new user
    ///   - password: the password for the new user
    ///   - completion: completion handler after creating new user, with error or _User_ object
    func createUser(email: String, password: String, completion: @escaping UserAuthCompletion)
    
    /// Logouts the user from the system
    /// - Parameter completion: error in case it occurs, otherwise nil
    func logoutUser(completion: @escaping (Error?) -> Void)
}

// MARK: - Default Implementation -

final class DefaultUserAuthUseCase: UserAuthUseCases {
    
    func loginUser(email: String, password: String, completion: @escaping UserAuthCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil, user != nil, let user = Auth.auth().currentUser, let email = user.email {
                completion(.success(User(uid: user.uid, email: email)))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping UserAuthCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil, user != nil, let user = Auth.auth().currentUser, let email = user.email {
                completion(.success(User(uid: user.uid, email: email)))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func logoutUser(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch (let error) {
            completion(error)
        }
    }
    
    
}
