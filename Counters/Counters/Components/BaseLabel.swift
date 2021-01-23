//
//  BaseLabel.swift
//  Counters
//
//  Created by Me on 19/01/21.
//

import UIKit

class BaseLabel: UILabel {
    
    var textStyle: UIFont.TextStyle = .body
    var alignment: NSTextAlignment = .left
    
    init(textStyle: UIFont.TextStyle = .body, alignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        self.textStyle = textStyle
        self.alignment = alignment
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        font = UIFont.preferredFont(forTextStyle: textStyle)
        adjustsFontForContentSizeCategory = true
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textAlignment = alignment
    }
}
