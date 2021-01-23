//
//  BaseView.swift
//  Counters
//
//  Created by Me on 19/01/21.
//

import UIKit

@IBDesignable
class BaseView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .systemBackground {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    // MARK: - Init / Setup
    init(cornerRadius: CGFloat, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}



