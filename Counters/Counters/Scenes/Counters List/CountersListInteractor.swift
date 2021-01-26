//
//  CountersListInteractor.swift
//  Counters
//
//  Created by Me on 22/01/21.
//

import Foundation

protocol CountersListInteractorProtocol {
    func start()
    func didPressErrorButton()
    func didPullToRefresh()
    func didSwitchEditMode(editing: Bool)
    func didChangeCounter(_ value: Int, at item: Int)
    func didSelectCounter(_ at: Int)
    func selectAllCounters()
    func deleteSelectedCounters()
    func didPressAddButton()
    func didCreateNew(_ counter: Counter)
}


class CountersListInteractor: CountersListInteractorProtocol {
    var presenter: CountersListPresenterProtocol
    var repository: CountersRepository
    
    var counters: [Counter] = []
    
    var listState: CountersListState = .loading {
        didSet {
           updateState(from: oldValue, to: listState)
        }
    }
    
    init(with presenter: CountersListPresenter, repository: CountersRepository) {
        self.presenter = presenter
        self.repository = repository
    }
    
    // Could also separate each case in a function to handle each state, I'd like to leave here to group and view all together easier.
    func updateState(from: CountersListState, to: CountersListState) {
        switch listState {
        case .loading:
            presenter.presentEditButton(enabled: false)
            presenter.presentListToolBar(countersCount: nil, countersSum: nil)
            presenter.presentLoading(true)
            fetchData()
        case .loadingError:
            presenter.presentEditButton(enabled: false)
            if from == .loading {
                presenter.presentLoading(false)
            } else if from == .refreshing {
            }
            let errorModel = ErrorMessageViewModel(title: LoadingErrorStrings.title, message: LoadingErrorStrings.message, buttonTittle: LoadingErrorStrings.actionTitle)
            presenter.presentError(errorModel)
            presenter.presentListToolBar(countersCount: nil, countersSum: nil)
        case .noContent:
            presenter.presentEditButton(enabled: false)
            let noContentModel = ErrorMessageViewModel(title: NoContentErrorStrings.title, message: NoContentErrorStrings.message, buttonTittle: NoContentErrorStrings.actionTitle)
            presenter.presentError(noContentModel)
            presenter.presentListToolBar(countersCount: nil, countersSum: nil)
        case .refreshing:
            presenter.presentEditButton(enabled: false)
            fetchData()
        case .hasContent:
            presenter.presentEditButton(enabled: true)
            presenter.presentDisplayMode(editing: false)
            presenter.presentList(counters)
            presenter.presentListToolBar(countersCount: counters.count, countersSum: Counters.sum(counters))
        case .editing:
            presenter.presentEditToolbar()
            presenter.presentDisplayMode(editing: true)
        case .sharing:
            presenter.presentEditToolbar()
        }
    }
    
    private func fetchData() {
        let hasContent = [Counter(id: "0", title: "Cups of Coffee", count: 4),
                          Counter(id: "1", title: "Apples eaten", count: 2),
                          Counter(id: "2", title: "Water glasses", count: 8)]
        
        // Couldn't use the mock node application, so I am mocking here. All the networking classes are ready in the Repository folder.
        // Not enough time to implement Core Data or Realm.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.counters = hasContent
            self?.listState = .hasContent
        }
    }
    
    // MARK: - CountersListInteractorProtocol
    func start() {
        listState = .loading
    }
    
    func didPressErrorButton() {
        if listState == .loadingError {
            listState = .loading
        } else if listState == .noContent {
            presenter.presentAddCounterScene()
        }
    }
    
    // MARK: - Pull to refresh Feature
    func didPullToRefresh() {
        listState = .refreshing
    }
    
    // MARK: - Edit Feature
    func didSwitchEditMode(editing: Bool) {
        if editing == true {
            listState = .editing
        } else {
            listState = counters.count > 0 ? .hasContent : .noContent
        }
    }
    
    // MARK: - Increment/Decrement Feature
    func didChangeCounter(_ value: Int, at item: Int) {
        guard item < counters.count else { return }
        let counter = counters[item]
        counter.count = value
        presenter.presentList(counters)
        presenter.presentListToolBar(countersCount: counters.count, countersSum: Counters.sum(counters))
    }
    
    // MARK: - Select Feature
    func didSelectCounter(_ at: Int) {
        guard counters.count > at else { return }
        counters[at].selected.toggle()
        presenter.presentList(counters)
    }

    func selectAllCounters() {
        counters.forEach {$0.selected = true}
        presenter.presentList(counters)
    }
    
    func deleteSelectedCounters() {
        self.counters = counters.filter({ $0.selected == false })
        presenter.presentList(counters)
    }

    // MARK: - Add Feature
    func didPressAddButton() {
        presenter.presentAddCounterScene()
    }
    
    func didCreateNew(_ counter: Counter) {
        counters.append(counter)
        listState = .hasContent
    }

}


