//
//  LoginViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: BaseDestinationViewController, Alertable {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var emailTxtField: RoundedTextField!
    @IBOutlet weak var passwordTxtField: RoundedTextField!
    
    @IBOutlet weak var loginbttn: RoundedShallowButton!
    
    fileprivate var viewModel: LoginViewModel = AppDIContainer().loginViewModel
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDidLoad()
        self.title = self.viewModel.screenTitle
        self.bind(to: self.viewModel)
    }
    
    // MARK: - Bttn Actions -
    
    @IBAction func loginTouchUpInside(_ sender: UIButton) {
        guard let email = self.emailTxtField.text, let password = self.passwordTxtField.text else { return }
        self.viewModel.loginUser(with: email, password: password)
    }
    
}

// MARK: - Util -

fileprivate extension LoginViewController {
    
    func bind(to viewModel: LoginViewModel) {
        viewModel.route.observe(on: self) { [weak self] in self?.handle($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showAlert(message: $0) }
    }
    
    func showAlert(message: String) {
        guard !message.isEmpty else { return }
        showAlert(title: NSLocalizedString("Error", comment: ""), message: message, severity: .error)
    }

}

// MARK: - Routing -

fileprivate extension LoginViewController {
    
    func handle(_ routing: LoginViewModelRoute) {
        switch routing {
        case .initial:
            break
        case .dashboard:
            self.navigate(.dashboard)
        }
    }
    
}
