//
//  LoginViewModel.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

enum LoginViewModelRoute {
    case initial
    case dashboard
}

protocol LoginViewModelInput {
    func viewDidLoad()
    func loginUser(with email: String, password: String)
}

protocol LoginViewModelOutput {
    var screenTitle: String { get }
    var route: Observable<LoginViewModelRoute> { get }
    var error: Observable<String> { get }
}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput { }

// MARK: - Default Implementation -

final class DefaultLoginViewModel: LoginViewModel {
    
    let screenTitle = "LOGIN"
    let route: Observable<LoginViewModelRoute> = Observable(.initial)
    let error: Observable<String> = Observable("")
    
    private let authUseCase: UserAuthUseCases
    
    @discardableResult
    init(authUseCase: UserAuthUseCases) {
        self.authUseCase = authUseCase
    }
    
    func viewDidLoad() { }
    
    func loginUser(with email: String, password: String) {
        self.setUserType(for: email)
        
        if (email.isEmpty || password.isEmpty) {
            self.error.value = "The email and password must be provided"
        } else {
            self.authUseCase.loginUser(email: email, password: password, completion: { result in
                switch result {
                case .success:
                    self.route.value = .dashboard
                case .failure(let error):
                    self.error.value = error.localizedDescription
                }
            })
        }
    }
    
    fileprivate func setUserType(for email: String) {
        if (email == "admin@atia.ba") {
            UserStateModel.shared.setUserType(.admin)
        } else {
            UserStateModel.shared.setUserType(.standard)
        }
    }
    
}
