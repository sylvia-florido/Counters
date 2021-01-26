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
        case .saving(let title):
            enterStateSaving(counterTitle: title)
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
    
    func enterStateSaving(counterTitle: String) {
        presenter.presentSaveOption(false)
        presenter.presenterActivityIndicator(true)
        saveCounter(with: counterTitle)
    }
    
    
    // MARK: - Save Feature
    func saveCounter(with counterTitle: String) {
        // Couldn't use the mock node application, so I am mocking here. All the networking classes are ready in the Repository folder.
        // Not enough time to implement Core Data or Realm.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let counter = Counter(id: "", title: counterTitle, count: 0)
            self?.presenter.presenterActivityIndicator(false)
            
            // Save Success
            self?.presenter.presentCounterListScene(with: counter)
            
            // Save Error - uncomment to test
//            self?.presenter.presentAlert(title: "Connection error", message: "Error connecting to the server.", buttonTitle: "Dismiss")
        }
    }
    
    // MARK: - AddCounterInteractorProtocol
    func start() {
        presenter.presentSubtitle(AddCounterStrings.subtitle, accentText: AddCounterStrings.accentSubtitle)
        presenter.presentPlaceholder(AddCounterStrings.textPlaceholder)
        creationState = .noContent
    }
    
    func didChange(text: String) {
        creationState = text.isEmpty ? .noContent : .content
    }

    func didBeginEditing() {
        switch creationState {
        case .noContent:
            presenter.presentPlaceholder("")
        default:
            break
        }
    }
        
    func didPressSaveButton(with text: String) {
        creationState = .saving(title: text)
    }
    
    // MARK: - Cancel Feature
    func didPressCancelButton() {
        presenter.presentCounterListScene(with: nil)
    }

   
}


struct AddCounterViewModel {
    let textPlaceholder: String
    let textTyped: String?
}
