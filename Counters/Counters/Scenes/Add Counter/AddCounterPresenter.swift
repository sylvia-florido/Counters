//
//  AddCounterPresenter.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import Foundation

protocol AddCounterPresenterProtocol {
    func presentSubtitle(_ text: String, accentText: String)
    func presentPlaceholder(_ text: String)
    func presenterActivityIndicator(_ visible: Bool)
    func presentSaveOption(_ enabled: Bool)
    func presentCounterListScene(with counter: Counter?)
    func presentAlert(title: String, message: String, buttonTitle: String)
}

class AddCounterPresenter: AddCounterPresenterProtocol {
    weak var controller: AddCounterViewControllerProtocol?
    
    init(with controller: AddCounterViewControllerProtocol) {
        self.controller = controller
    }
    
    // MARK: - AddCounterPresenterProtocol
    func presentSubtitle(_ text: String, accentText: String) {
        let attributedText = text.getAttributedString()
        attributedText.underLine(subString: accentText)
        controller?.displaySubtitle(attributedText)
    }
    
    func presentPlaceholder(_ text: String) {
        controller?.displayPlaceholder(text)
    }
    
    func presenterActivityIndicator(_ visible: Bool) {
        controller?.displayActivityIndicator(visible)
    }

    func presentSaveOption(_ enabled: Bool) {
        controller?.displaySaveOption(enabled)
    }

    func presentCounterListScene(with counter: Counter?) {
        controller?.displayCountersListScene(with: counter)
    }
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        controller?.displayAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
}
