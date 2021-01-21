//
//  WelcomeInteractor.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import Foundation

protocol WelcomeInteractorProtocol {
    func continueButtonPressed()
}

class WelcomeInteractor: WelcomeInteractorProtocol {
    var presenter: WelcomePresenterProtocol
    var repository: CountersRepository
    
    init(with presenter: WelcomePresenterProtocol, repository: CountersRepository) {
        self.presenter = presenter
        self.repository = repository
    }
    
    // MARK: - WelcomeInteractorProtocol
    func continueButtonPressed() {
        presenter.presentCountersListScene()
    }

}
