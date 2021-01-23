//
//  Sequence+Extension.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import Foundation

extension Sequence {
    func sum<T: Numeric>(for keyPath: KeyPath<Element, T>) -> T {
        return reduce(0) { sum, element in
            sum + element[keyPath: keyPath]
        }
    }
}
