//
//  DoctorDetailViewModel.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

enum AppointmentBookingStatus {
    case none
    case success(String)
    case failed(Error)
}

protocol DoctorDetailViewModelInput {
    func viewDidLoad()
    func bookAppointment(for date: String)
}

protocol DoctorDetailViewModelOutput {
    var screenTitle: String { get }
    var doctorsList: [Doctor] { get }
    var state: Observable<AppointmentBookingStatus> { get }
    func getDateFormatted(for date: Date) -> String
}

protocol DoctorDetailViewModel: DoctorDetailViewModelInput, DoctorDetailViewModelOutput { }

// MARK: - Default Implementation -

final class DefaultDoctorViewModel: DoctorDetailViewModel {
    
    var doctorsList: [Doctor] {
        var list = [Doctor]()
        
        self.doctorUseCase.getDoctorList({ result in
            switch result {
            case .failure:
                break
            case .success(let doctors):
                list = doctors
            }
        })
        
        return list
    }
    
    var screenTitle: String {
        return "\(doctor.firstName) \(doctor.lastName)"
    }
    
    let state: Observable<AppointmentBookingStatus> = Observable(.none)
    let appointmentUseCase: AppointmentUseCase
    let doctorUseCase: DoctorUseCases
    let doctor: Doctor
    
    init(doctor: Doctor,
         appointmentUseCases: AppointmentUseCase,
         doctorUseCases: DoctorUseCases
    ) {
        self.doctor = doctor
        self.appointmentUseCase = appointmentUseCases
        self.doctorUseCase = doctorUseCases
    }
    
    func viewDidLoad() {
        
    }
    
    func bookAppointment(for date: String) {
        self.appointmentUseCase.bookAppointment(self.doctor, date: date, completion: { result in
            switch result {
            case .success:
                self.state.value = .success("Appointment sucessfully added for \(self.doctor.firstName) \(self.doctor.lastName)")
            case .failure(let error):
                self.state.value = .failed(error)
            }
        })
    }
    
    func getDateFormatted(for date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        
        return "\(formatter.string(from: date))"
    }
    
}
