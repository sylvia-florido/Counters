//
//  WelcomePresenter.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import Foundation

protocol WelcomePresenterProtocol {
    func presentCountersListScene()
}

class WelcomePresenter: WelcomePresenterProtocol {
    weak var controller: WelcomeViewControllerProtocol?
    
    init(with controller: WelcomeViewControllerProtocol) {
        self.controller = controller
    }
    
    // MARK: - WelcomePresenterProtocol
    func presentCountersListScene() {
        controller?.routeToCountersListScene()
    }
}
