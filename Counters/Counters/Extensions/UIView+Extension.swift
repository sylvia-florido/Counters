//
//  UIView+Extension.swift
//  Counters
//
//  Created by Me on 19/01/21.
//

import UIKit

extension UIView {
    func pin(to superview: UIView, constant: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
    }
    
    func center(to superview: UIView, minPadding: CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        if let constant = minPadding {
            superview.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: constant).isActive = true
            superview.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: constant).isActive = true
            superview.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: constant).isActive = true
            superview.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: constant).isActive = true
        }
    }
    
}
