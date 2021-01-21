//
//  NibInstantiable.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import Foundation
import UIKit

public protocol NibInstantiable {
    static var nibName: String { get }
}

extension NibInstantiable {
    public static var nibName: String {
        return String(describing: self)
    }
}

public extension NibInstantiable where Self: UIViewController {
    static func initFromNib() -> Self {
        return Self(nibName: nibName, bundle: Bundle(for: self))
    }
}

public extension NibInstantiable where Self: UIView {
    static func initFromNib() -> Self {
        guard let view =  UINib(nibName: nibName, bundle: Bundle(for: self)).instantiate(withOwner: self, options: nil).first as? Self else { fatalError("There is no xib/nib to instantiate this view, please provide one before using this func.") }
        return view
    }
}
