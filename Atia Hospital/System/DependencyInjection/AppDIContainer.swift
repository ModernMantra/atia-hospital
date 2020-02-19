//
//  AppDIContainer.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Use Cases -
    
    lazy var appointmentUseCase: AppointmentUseCase = {
        return DefaultAppointmentUseCases()
    }()
    
    lazy var userAuthUseCases: UserAuthUseCases = {
        return DefaultUserAuthUseCase()
    }()
    
    lazy var doctorUseCases: DoctorUseCases = {
        return DefaultDoctoUseCases()
    }()
    
    // MARK: - View Models -
    
    lazy var loginViewModel: LoginViewModel = {
        return DefaultLoginViewModel(authUseCase: self.userAuthUseCases)
    }()
    
    lazy var signupViewModel: SignupViewModel = {
        return DefaultSignupViewModel(useCase: self.userAuthUseCases)
    }()
    
    lazy var requestListViewModel: RequestListViewModel = {
        return DefaultRequestListViewModel(useCase: self.appointmentUseCase)
    }()
    
    lazy var doctorListViewModel: DoctorListViewModel = {
        return DefaultDoctorListViewModel(useCase: self.doctorUseCases)
    }()
    
}
