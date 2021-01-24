//
//  NSMutableAttributedString+Color.swift
//  Counters
//
//  Created by Me on 24/01/21.
//

import UIKit

extension NSMutableAttributedString {
    func apply(color: UIColor, subString: String) {
        
        if let range = self.string.range(of: subString) {
            self.apply(color: color, onRange: NSRange(range, in:self.string))
        }
    }
    func apply(color: UIColor, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                           range: onRange)
    }
}
