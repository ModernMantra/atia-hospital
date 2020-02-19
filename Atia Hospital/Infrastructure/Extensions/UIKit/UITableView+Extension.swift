//
//  UITableView+Extension.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView {
    static var nibName: String {
        return String(describing: self)
    }
}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension ReusableView {
    static var defaultReuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return nil }
}

extension UITableViewCell: ReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableView {

    /// Will create Nib from given cell class and then will register on table view.
    ///
    /// - Parameter cell: cell name
    public func register(_ cell: AnyClass) {
        let cellClassName = String(describing: cell)
        let tableViewCell = UINib(nibName: cellClassName, bundle: nil)
        self.register(tableViewCell, forCellReuseIdentifier: cellClassName)
    }

    /// Newer version of function to deque cell. Namely, It uses generics,
    /// takes as an argument a class of a cell, an indexPath and a configure closure
    /// to which a cell of desired type (i.e. of CellClass.Type) is passed. No more guard usage :)
    ///
    /// - Returns: return dequed table view cell
    public func dequeueReusableCell<CellClass: UITableViewCell>(of class: CellClass.Type, for indexPath: IndexPath, configure: ((CellClass) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CellClass.identifier, for: indexPath)

        if let typedCell = cell as? CellClass {
            configure(typedCell)
        }

        return cell
    }

    /// Register cell with automatically setting Identifier
    public func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// Get cell with the default reuse cell identifier
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: NSIndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    /// Reloading table view might cause glitch and setting table view scroll to the top
    /// With this method, content offset will be saved and set again after realoding
    func reloadWithoutScroll() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }

}
