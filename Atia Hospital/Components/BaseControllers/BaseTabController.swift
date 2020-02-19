//
//  BaseTabController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

/// Base implementation of the tab bar appearance.
class BaseTabBarController: UITabBarController {
    
    // MARK: - Properties -
    
    fileprivate let selectedColor: UIColor = UIColor(.highlight)
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupTabBarAppearance() {
        self.tabBar.tintColor = selectedColor
        self.tabBar.unselectedItemTintColor = UIColor(.textPrimary)
        self.tabBar.backgroundColor = UIColor(.background)
        self.tabBar.isTranslucent = false
    }
    
}
