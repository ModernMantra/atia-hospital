//
//  DoctorUseCases.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

protocol DoctorUseCases {
    typealias DoctorResult = (Result<[Doctor], Error>) -> Void
    
    /// Returns the list of all available doctor objects found.
    func getDoctorList(_ completion: DoctorResult)
}

// MARK: - Default Implementation -

final class DefaultDoctoUseCases: DoctorUseCases {
    
    func getDoctorList(_ completion: (Result<[Doctor], Error>) -> Void) {
        let doctors: [Doctor] = [
            Doctor(email: "john@gmail.com", firstName: "John", lastName: "Johnny", uid: "1"),
            Doctor(email: "karoline@gmail.com", firstName: "Karoline", lastName: "Wang", uid: "2"),
            Doctor(email: "johnson@gmail.com", firstName: "Johnson", lastName: "Stella", uid: "3"),
            Doctor(email: "sebastian@gmail.de", firstName: "Sebastian", lastName: "Gronemeyer", uid: "4"),
            Doctor(email: "herbert@gmail.de", firstName: "Herbert", lastName: "Dietiker", uid: "5")
        ]
        completion(.success(doctors))
    }
    
}
