//
//  Collection+Extension.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 19/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns element in the collection if exists with given index,
    /// otherwise nil.
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
    
}
