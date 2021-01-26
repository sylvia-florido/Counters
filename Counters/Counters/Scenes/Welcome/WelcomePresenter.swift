//
//  WelcomePresenter.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import Foundation

protocol WelcomePresenterProtocol {
    func presentTitle(_ text: String, accentWord: String)
    func presentCountersListScene()
}

class WelcomePresenter: WelcomePresenterProtocol {
    weak var controller: WelcomeViewControllerProtocol?
    
    init(with controller: WelcomeViewControllerProtocol) {
        self.controller = controller
    }
    
    // MARK: - WelcomePresenterProtocol
    func presentTitle(_ text: String, accentWord: String) {
        let attributedString = text.getAttributedString()
        if let accentColor = Colors.accentMainColor {
            attributedString.apply(color: accentColor, subString: accentWord)
        }
        controller?.displayTitle(attributedString)
    }
    
    func presentCountersListScene() {
        controller?.routeToCountersListScene()
    }
}
