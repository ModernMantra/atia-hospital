//
//  UIColor+Extension.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 15/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

/// Collection of all available colors from assets used within the app.
/// *In case the new colors are added/used, expand the list.*
enum ColorPalette: String {
    case highlight = "highlighted"
    case backgroundPrimary = "background-primary"
    case backgroundSecondary = "background-secondary"
    case background = "background"
    case textPrimary = "text-primary"
    case textSecondary = "text-secondary"
}

extension UIColor {
    
    /// Convenience initialiser to use custom structure for initialisation
    /// - Parameter palette: palette
    convenience init(_ palette: ColorPalette) {
        self.init(named: palette.rawValue)!
    }
}
