//
//  WelcomeInteractor.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import Foundation

protocol WelcomeInteractorProtocol {
    func viewdidLoad()
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
    func viewdidLoad() {
        presenter.presentTitle(WelcomeStrings.title, accentWord: WelcomeStrings.accentTitle)
    }
    
    func continueButtonPressed() {
        presenter.presentCountersListScene()
    }

}
