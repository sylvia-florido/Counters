//
//  NSMutableAttributedString+Underline.swift
//  Counters
//
//  Created by Me on 24/01/21.
//

import Foundation

extension NSMutableAttributedString {

    func underLine(subString: String) {
        if let range = self.string.range(of: subString) {
            self.underLine(onRange: NSRange(range, in: self.string))
        }
    }
    func underLine(onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue],
                           range: onRange)
    }
}
