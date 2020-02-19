//
//  SplashViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 10/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var placeHolderContainerView: UIView!
    
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    @IBOutlet weak var nextBttn: RoundedFilledButton!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Bttn Actions -
    
    @IBAction func nextBttnTouchUpInside(_ sender: UIButton) {
        self.navigate(.loginAndRegister)
    }

}
