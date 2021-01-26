//
//  UIAlertController+Extension.swift
//  Counters
//
//  Created by Me on 24/01/21.
//

import UIKit

extension UIAlertController {
    class func show(from controller: UIViewController,
                    title: String?,
                    message: String,
                    preferredButtonTitle: String,
                    handler: ( (UIAlertAction) -> Void )?,
                    additionalButtonTitle: String? = nil,
                    additionalHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.accentMainColor
        let preferredAction = UIAlertAction(title: title, style: .default, handler: handler)
        alert.addAction(preferredAction)
        alert.preferredAction = preferredAction
        if let buttonTitle = additionalButtonTitle {
            let additionalAction = UIAlertAction(title: buttonTitle, style: .default, handler: additionalHandler)
            alert.addAction(additionalAction)
        }
        controller.present(alert, animated: true, completion: nil)
    }
}
