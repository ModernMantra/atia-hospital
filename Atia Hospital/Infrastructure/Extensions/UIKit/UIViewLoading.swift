//
//  UIViewLoading.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

protocol UIViewLoading {}
extension UIView: UIViewLoading {}

extension UIViewLoading where Self: UIView {
    
    /// This method returns an instance of type `Self`, rather than UIView
    /// By conforming thr UIView to `UIViewLoading` protocol, this method
    /// coul dbe used to instantiate the view without force casting.
    static func loadFromNib() -> Self {
        let nibName = "\(self)".split{ $0 == "." }.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
}
