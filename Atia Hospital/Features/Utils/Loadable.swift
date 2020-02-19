//
//  Loadable.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

public protocol Loadable {}
public extension Loadable where Self: UIViewController {
    
    func showLoading(activityView: UIActivityIndicatorView) {
        activityView.center = self.view.center
        activityView.startAnimating()

        self.view.addSubview(activityView)
    }
    
    func removeLoading(activityView: UIActivityIndicatorView) {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }

}
