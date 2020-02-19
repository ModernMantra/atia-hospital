//
//  ApplicationNavigation.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

/// Collection of all available navigations that could be found within the app.
/// The navigation types collection conforms to protocol `Navigation` and `AppNavigation`
/// in order to make easier instantiation of view controller and storyboard and avoiding
/// the massive view controller.
///
/// Example (in view controller):
/// ```
/// self.navigate(.userDetail(model))
/// ```
enum NavigationTypes {
    case signup
    case login
    case loginAndRegister
    case dashboard
    case doctorDetail(model: Doctor)
}

// MARK: - Navigation Protocol Conformance -

extension NavigationTypes: Navigation {
    var storyboard: UIStoryboard {
        switch self {
        case .login,
             .loginAndRegister:
            return UIStoryboard(name: "Login", bundle: nil)
        case .signup:
            return UIStoryboard(name: "Signup", bundle: nil)
        case .dashboard:
            return UIStoryboard(name: "Dashboard", bundle: nil)
        case .doctorDetail:
            return UIStoryboard(name: "Doctor", bundle: nil)
        }
    }
}

// MARK: - App Navigation Protocol Conformance -

struct ApplicationNavigation: AppNavigation {

    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? NavigationTypes {
            switch navigation {
            case .login:
                let vc: LoginViewController = navigation.storyboard.instantiateViewController()
                return vc
            case .signup:
                let vc: SignupViewController = navigation.storyboard.instantiateViewController()
                return vc
            case .loginAndRegister:
                let vc: LoginAndRegisterViewController = navigation.storyboard.instantiateViewController()
                return vc
            case .dashboard:
                let vc: MainTabBarViewController = navigation.storyboard.instantiateViewController()
                return vc
            case .doctorDetail(let model):
                let vc: DoctorDetailViewController = navigation.storyboard.instantiateViewController()
                vc.model = model
                vc.hidesBottomBarWhenPushed = true
                return vc
            }
        }

        return UIViewController()
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        if let navType = navigation as? NavigationTypes {
            switch navType {
            default:
                from.navigationController?.pushViewController(to, animated: true)
            }
        }
    }

}

extension UIViewController {

    func navigate(_ navigation: NavigationTypes) {
        navigate(navigation as Navigation)
    }

}
