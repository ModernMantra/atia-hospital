//
//  Alert.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import SwiftMessages

public enum AlertSeverity {
    case info
    case success
    case warning
    case error
}

public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, severity: AlertSeverity, completion: (() -> Void)? = nil) {
        var config = SwiftMessages.Config()
        let view: MessageView
        
        switch severity {
        case .error:
            view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.error)
        case .info:
            view = MessageView.viewFromNib(layout: .statusLine)
            view.configureTheme(.info)
        case .warning:
            view = MessageView.viewFromNib(layout: .statusLine)
            view.configureTheme(.warning)
        case .success:
            view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(.success)
        }
        
        
        config.presentationStyle = .top
        config.presentationContext = .automatic
        config.duration = .seconds(seconds: 5)
        
        view.configureDropShadow()
        view.configureContent(title: "", body: message)
        view.button?.setTitle("OK", for: .normal)
        view.buttonTapHandler = { _ in
            SwiftMessages.hide()
        }
        
        SwiftMessages.show(view: view)
    }
}
