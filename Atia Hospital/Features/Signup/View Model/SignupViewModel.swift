//
//  SignupViewModel.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

enum SignupViewModelRoute {
    case initial
    case login
}

protocol SignupViewModelInput {
    func viewDidLoad()
    func createUser(email: String, password: String)
}

protocol SignupViewModelOutput {
    var screenTitle: String { get }
    var route: Observable<SignupViewModelRoute> { get }
    var error: Observable<String> { get }
}

protocol SignupViewModel: SignupViewModelInput, SignupViewModelOutput { }

// MARK: - Default Implementation -

final class DefaultSignupViewModel: SignupViewModel {
    
    let screenTitle = "SIGNUP"
    let route: Observable<SignupViewModelRoute> = Observable(.initial)
    var error: Observable<String> = Observable("")
    let signupUseCase: UserAuthUseCases
    
    @discardableResult
    init(useCase: UserAuthUseCases) {
        self.signupUseCase = useCase
    }
    
    func viewDidLoad() { }
    
    func createUser(email: String, password: String) {
        self.signupUseCase.createUser(email: email, password: password, completion: { result in
            switch result {
            case .failure(let error):
                self.error.value = error.localizedDescription
            case .success:
                self.route.value = .login
            }
        })
    }
    
}
