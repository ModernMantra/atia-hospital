//
//  MainTabBarViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit

class MainTabBarViewController: BaseTabBarController {
            
    // MARK: - Tab Bar Controllers -

    fileprivate lazy var doctorList: DoctorListViewController = {
        let vc: DoctorListViewController = UIStoryboard(name: "Doctor", bundle: nil).instantiateViewController()
        
        vc.tabBarItem = UITabBarItem(
            title: "Doctors",
            image: UIImage(named: "bookmark"),
            tag: 0
        )
        
        return vc
    }()
    
    fileprivate lazy var requestList: RequestListViewController = {
        let vc: RequestListViewController = UIStoryboard(name: "Request", bundle: nil).instantiateViewController()
        
        vc.tabBarItem = UITabBarItem(
            title: "Requests",
            image: UIImage(named: "requests"),
            tag: 1
        )
        
        return vc
    }()
    
    // MARK: - View Controller Life Cycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        self.setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Util -
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    fileprivate func loadTabBar() {
        var viewControllersList = [UIViewController]()
        
        switch UserStateModel.shared.userType {
        case .admin:
            viewControllersList.append(self.requestList)
        case .standard:
            viewControllersList.append(self.doctorList)
            viewControllersList.append(self.requestList)
        }

        self.viewControllers = viewControllersList
        self.viewControllers = viewControllersList.map({ UINavigationController(rootViewController: $0) })
    }

}

// MARK: - UI Tab Bar Controller Delegate -

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // let index = tabBarController.selectedIndex
        // let controller = self.viewControllers?[index]
    }
    
}
