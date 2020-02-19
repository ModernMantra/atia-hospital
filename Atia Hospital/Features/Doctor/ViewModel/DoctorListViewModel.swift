//
//  DoctorListViewModel.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

public enum DoctorListCellType: CaseIterable {
    case doctor
    
    var cellClass: AnyClass {
        switch self {
        case .doctor:
            return DoctorTableViewCell.self
        }
    }

}

enum DoctorListRouting {
    case none
    case details(Doctor)
}

protocol DoctorListInput {
    func didSelected(doctor: Doctor)
}

protocol DoctorListOutput {
    var doctors: [Doctor] { get }
    var routing: Observable<DoctorListRouting> { get }
    var error: Observable<String> { get }
}

protocol DoctorListViewModel: DoctorListInput, DoctorListOutput { }

// MARK: - Default implementation -

final class DefaultDoctorListViewModel: DoctorListViewModel {

    var doctors: [Doctor] {
        var items = [Doctor]()
        
        self.useCase.getDoctorList({ result in
            switch result {
            case .failure(let error):
                self.error.value = error.localizedDescription
            case .success(let doctors):
                items = doctors
            }
        })
        
        return items
    }
    let error: Observable<String> = Observable("")
    let routing: Observable<DoctorListRouting> = Observable(.none)
    let useCase: DoctorUseCases
    
    init(useCase: DoctorUseCases) {
        self.useCase = useCase
    }
    
    func didSelected(doctor: Doctor) {
        self.routing.value = .details(doctor)
    }
    
}
