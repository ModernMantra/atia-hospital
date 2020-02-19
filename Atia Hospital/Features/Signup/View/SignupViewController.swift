//
//  SignupViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: BaseDestinationViewController, Alertable {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var firstNameTxtField: RoundedTextField!
    @IBOutlet weak var lastNameTxtField: RoundedTextField!
    @IBOutlet weak var emailTxtField: RoundedTextField!
    @IBOutlet weak var passwordTxtField: RoundedTextField!
    
    @IBOutlet weak var signupBttn: RoundedFilledButton!
    
    fileprivate let viewModel = AppDIContainer().signupViewModel
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDidLoad()
        self.title = self.viewModel.screenTitle
        self.bind(to: self.viewModel)
    }
    
    // MARK: - Bttn Action -
    
    @IBAction func signupTouchUpInside(_ sender: UIButton) {
        guard let email = self.emailTxtField.text, let password = self.passwordTxtField.text else { return }
        self.viewModel.createUser(email: email, password: password)
    }
    
}

// MARK: - Util -

fileprivate extension SignupViewController {
    
    func bind(to viewModel: SignupViewModel) {
        viewModel.route.observe(on: self) { [weak self] in self?.handle($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showAlert(message: $0) }
    }
    
    func showAlert(message: String) {
        guard !message.isEmpty else { return }
        showAlert(title: NSLocalizedString("Error", comment: ""), message: message, severity: .error)
    }
    
}

// MARK: - Routing -

fileprivate extension SignupViewController {
    
    func handle(_ routing: SignupViewModelRoute) {
        switch routing {
        case .initial:
            break
        case .login:
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
