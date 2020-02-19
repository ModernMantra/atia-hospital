//
//  LoginAndRegisterViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 10/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Firebase

class LoginAndRegisterViewController: BaseDestinationViewController {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var bottomContainerView: UIView! {
        didSet { self.setupContainerViewApparance() }
    }
    
    @IBOutlet weak var signupBttn: RoundedShallowButton!
    @IBOutlet weak var loginBttn: RoundedFilledButton!

    // MARK: - Lifecyle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOGIN & REGISTER"
    }
    
    // MARK: - Button Actions -
    
    @IBAction func signupTouchUpInside(_ sender: UIButton) {
        self.navigate(.signup)
    }
    
    @IBAction func loginTouchUpInside(_ sender: UIButton) {
        self.navigate(.login)
    }
    
}

// MARK: - Utils -

fileprivate extension LoginAndRegisterViewController {
    
    func setupContainerViewApparance() {
        self.bottomContainerView.layer.cornerRadius = 30
        self.bottomContainerView.layer.masksToBounds = true
    }
    
}
