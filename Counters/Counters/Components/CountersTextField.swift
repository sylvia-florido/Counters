//
//  CountersTextField.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import UIKit

class CountersTextField: UITextField {
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: Setup
    internal func setup() {
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = UIColor.label
        borderStyle = .none
        tintColor = Colors.accentMainColor
        layer.cornerRadius = 8
    }
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
