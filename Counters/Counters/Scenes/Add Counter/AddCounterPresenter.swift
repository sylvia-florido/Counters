//
//  AddCounterPresenter.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import Foundation

protocol AddCounterPresenterProtocol {
    func presentPlaceholder(_ text: String)
    func presenterActivityIndicator(_ visible: Bool)
    func presentSaveOption(_ enabled: Bool)
    func presentCancelAction()
}

class AddCounterPresenter: AddCounterPresenterProtocol {
    weak var controller: AddCounterViewControllerProtocol?
    
    init(with controller: AddCounterViewControllerProtocol) {
        self.controller = controller
    }
    
    // MARK: - AddCounterPresenterProtocol
    func presentPlaceholder(_ text: String) {
        controller?.displayPlaceholder(text)
    }
    
    func presenterActivityIndicator(_ visible: Bool) {
        controller?.displayActivityIndicator(visible)
    }

    func presentSaveOption(_ enabled: Bool) {
        controller?.displaySaveOption(enabled)
    }

    func presentCancelAction() {
        controller?.displayCancelAction()
    }
}
