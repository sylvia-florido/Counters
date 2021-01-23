//
//  ErrorMessageView.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

/*
    Technique used in this class - Use enumerations to capture state from Apple
    https://developer.apple.com/documentation/swift/maintaining_state_in_your_apps
    https://www.swiftbysundell.com/articles/modelling-state-in-swift/
 */

import UIKit

enum ErrorMessageViewState {
    case warning(message: String)
    case action(viewModel: ErrorMessageViewModel, action: (() -> Void))
}

class ErrorMessageView: UIView, NibInstantiable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: RoundedButton!
    
    var errorMessageState: ErrorMessageViewState = .warning(message:"") {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setup()
    }
    
    func setup() {
        switch errorMessageState {
        case .action(let viewModel, _):
            self.titleLabel.text = viewModel.title
            self.messageLabel.text = viewModel.message
            self.button.setTitle(viewModel.buttonTittle, for: .normal)
            titleLabel.isHidden = false
            button.isHidden = false
        case .warning(let message):
            messageLabel.text = message
            titleLabel.isHidden = true
            button.isHidden = true
        }
    }
    
    private func setupAccessibility() {
        isAccessibilityElement = false
        
        [titleLabel, messageLabel].forEach { (label) in
            label?.isAccessibilityElement = true
            label?.accessibilityTraits = .staticText
            label?.accessibilityLabel = label?.text
        }
        
        button.isAccessibilityElement = true
        button.accessibilityTraits = .button
        button.accessibilityLabel = button.titleLabel?.text
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard case let .action(_, action) = errorMessageState else {
            return
        }
        action()
    }
    
}
