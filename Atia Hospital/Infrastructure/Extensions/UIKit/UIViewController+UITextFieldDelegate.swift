//
//  UIViewController+UITextFieldDelegate.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: UITextFieldDelegate {
    
    /// Adds toolbar without causing the boilerplate code within the view controllers.
    /// - Parameter textField: text field on which to attach the toolbar
    public func addToolBar(textField: UITextField){
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        textField.inputAccessoryView = toolbar
    }
    
    // MARK: - Toolbar Selectors -
    
    @objc public func doneDatePicker(){
        self.view.endEditing(true)
    }

    @objc public func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
