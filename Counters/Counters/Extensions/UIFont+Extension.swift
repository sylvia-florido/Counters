//
//  UIFont+Extension.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import UIKit

extension UIFont {
    
    static func systemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight, design: UIFontDescriptor.SystemDesign) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: fontSize)
        } else {
            return systemFont
        }
    }
}
