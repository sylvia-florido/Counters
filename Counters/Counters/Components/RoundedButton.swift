//
//  RoundedButton.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    // MARK: - Init / Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        backgroundColor = Colors.accentMainColor
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        setTitleColor(.white, for: .disabled)
        
        applyShadow()
    }
    
    private func applyShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        layer.shadowRadius = 8.0
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 8, dy: 8), cornerRadius: 8).cgPath
    }

    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
