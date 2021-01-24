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
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.accentMainColor
        ]
        let range = (text as NSString).range(of: accentWord)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(attributes, range: range)
        controller?.displayTitle(attributedString)
    }
    
    func presentCountersListScene() {
        controller?.routeToCountersListScene()
    }
}
