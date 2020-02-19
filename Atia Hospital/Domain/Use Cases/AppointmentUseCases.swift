//
//  AppointmentUseCases.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import Firebase

enum AppointmentError: Error {
    case emptyList
    
    var localizedDescription: String {
        switch self {
        case .emptyList:
            return "The list is empty"
        }
    }
}

/// Basic behaviour definition for the use cases associated with the appointment.
/// Following use cases are covered:
///  - retriving list of all appointment
///  - retrieving list of approved appointments
///  - booking appointment
///  - approving/declining appointment
protocol AppointmentUseCase {
    typealias AppointmentResult = (Result<Event, Error>) -> Void
    typealias AppointmentResults = (Result<[Event], Error>) -> Void
    
    /// Books the appointment nad saves in relatime database
    /// - Parameters:
    ///   - event: event objects
    ///   - completion: completion handler with result containg booked object or error
    func bookAppointment(_ doctor: Doctor, date: String, completion: @escaping AppointmentResult)
    
    /// Returns list of all appointments filtered by id of the currently logged user
    /// - Parameter completion: result with error or list of appointments
    func getApprovedAppointments(completion: @escaping AppointmentResults)
    
    /// List of all apèpointments
    /// - Parameter completion: completion hnadler with error or list of app.
    func getAllAppointments(completion: @escaping AppointmentResults)
    
    /// Updates the appointment flag `approved`
    /// - Parameters:
    ///   - event: the event to be updated
    ///   - approved: appropved flag
    ///   - completion: completion handler
    func updateAppointment(_ event: Event, approved: Bool, completion: () -> Void)
}

// MARK: - Default Implementation -

final class DefaultAppointmentUseCases: AppointmentUseCase {
    
    func getAllAppointments(completion: @escaping AppointmentResults) {
        let ref = Database.database().reference(fromURL: "https://atia-hospital.firebaseio.com")
        var newItems: [Event] = []
        
        ref.observe(.value, with: { snapshot in
            if snapshot.childrenCount == 0 {
                completion(.failure(AppointmentError.emptyList))
            } else {
                newItems.removeAll()
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot, let item = Event(snapshot: snapshot) {
                        newItems.append(item)
                    }
                }
                completion(.success(newItems))
            }
        })
    }
    
    func updateAppointment(_ event: Event, approved: Bool, completion: () -> Void) {
        event.ref?.updateChildValues([
          "approved": approved
        ])
        completion()
    }
    
    func bookAppointment(_ doctor: Doctor, date: String, completion: (Result<Event, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(AuthError.noCurrentUser))
            return
        }
        let ref = Database.database().reference(withPath: "appointment-\(user.uid)-\(doctor.uid)")
        let event = Event(
            doctorUID: doctor.uid,
            date: date,
            approved: false,
            userUID: user.uid,
            doctorName: "\(doctor.firstName) \(doctor.lastName)",
            userName: user.email!
        )
        
        ref.setValue(event.toAnyObject())
        completion(.success(event))
    }
    
    func getApprovedAppointments(completion: @escaping AppointmentResults) {
        let ref = Database.database().reference(fromURL: "https://atia-hospital.firebaseio.com")
        var newItems: [Event] = []
        
        ref.observe(.value, with: { snapshot in
            if snapshot.childrenCount == 0 {
                completion(.failure(AppointmentError.emptyList))
            } else {
                newItems.removeAll()
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot, let item = Event(snapshot: snapshot), Auth.auth().currentUser?.uid == item.userUID, item.approved == true {
                        newItems.append(item)
                    }
                }
                completion(.success(newItems))
            }
        })
    }
    
}
