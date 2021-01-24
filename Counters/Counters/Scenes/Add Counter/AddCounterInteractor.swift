//
//  AddCounterInteractor.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import Foundation

protocol AddCounterInteractorProtocol {
    func start()
    func didBeginEditing()
    func didChange(text: String)
    func didPressSaveButton(with text: String)
    func didPressCancelButton()
}

class AddCounterInteractor: AddCounterInteractorProtocol {
    
    var presenter: AddCounterPresenterProtocol
    var repository: CountersRepository
    
    var counter: Counter?
   
    var creationState: CounterCreationState = .noContent {
        didSet {
           updateState(from: oldValue, to: creationState)
        }
    }
    
    init(with presenter: AddCounterPresenterProtocol, repository: CountersRepository) {
        self.presenter = presenter
        self.repository = repository
    }

    func updateState(from: CounterCreationState, to: CounterCreationState) {
        switch creationState {
        case .noContent:
            enterStateNoContent()
        case .content:
            enterStateContent()
        case .saving:
            print("saving")
        }
    }
    
    func enterStateNoContent() {
        presenter.presenterActivityIndicator(false)
        presenter.presentSaveOption(false)
    }
    
    func enterStateContent() {
        presenter.presenterActivityIndicator(false)
        presenter.presentSaveOption(true)
    }
    
    // MARK: - AddCounterInteractorProtocol
    func start() {
        presenter.presentPlaceholder(AddCounterStrings.textPlaceholder)
        creationState = .noContent
    }
    
    func didChange(text: String) {
        creationState = text.isEmpty ? .noContent : .content
    }


    func didBeginEditing() {
        if creationState == .noContent {
            presenter.presentPlaceholder("")
        }
    }
        
    func didPressSaveButton(with text: String) {
        presenter.presenterActivityIndicator(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.counter = Counter(id: "", title: text, count: 0)
            self?.presenter.presenterActivityIndicator(false)
        }
    }
    
    func didPressCancelButton() {
        presenter.presentCancelAction()
    }

   
}


struct AddCounterViewModel {
    let textPlaceholder: String
    let textTyped: String?
}
