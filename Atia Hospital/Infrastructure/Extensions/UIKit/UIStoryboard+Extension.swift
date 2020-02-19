//
//  UIStoryboard+Extension.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

public extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

/// Let Every view controller conform to the protocol so
/// it can be very easily be done this:
/// ```
///     let vc: LoginvViewController = StoryboardScene.Login.storyboard.instantiateViewController()
/// ```
extension UIViewController: StoryboardIdentifiable {

}

public extension UIStoryboard {

    /// Will instantiate the view controller without using old school way with identifier. On the left side of the equality sign
    /// it has to be specified exact name of the class to which view controller will be casted

    /// Example:
    /// ```
    /// let viewController: HomeMainViewController = Storyboard(.main).instantiateViewController
    /// ```
    ///
    /// - Returns: returns instantiated view controller
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
    
}
