//
//  RoundedFilledButton.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

/// Custom button implementation used across the app, made in separate file to avoid boilerplate code.
/// The design contains line around button with corner radius.
@IBDesignable
open class RoundedFilledButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        self.layer.cornerRadius = (self.frame.size.height * 0.5)
        self.layer.masksToBounds = true
    }
    
}
