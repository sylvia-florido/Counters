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
    func didEnterEditMode()
    func didChangeCounter(_ value: Int, at item: Int)
    func didSelectCounter(_ at: Int)
    func selectAllCounters()
    func deleteSelectedCounters()
}


class CountersListInteractor: CountersListInteractorProtocol {
    var presenter: CountersListPresenter
    var repository: CountersRepository
    
    var counters: [Counter] = []
    
    var listState: CounterState = .loading {
        didSet {
           updateState(from: oldValue, to: listState)
        }
    }
    
    init(with presenter: CountersListPresenter, repository: CountersRepository) {
        self.presenter = presenter
        self.repository = repository
    }
    
    func updateState(from: CounterState, to: CounterState) {
        switch listState {
        case .loading:
            // show loading screen
            presenter.presentListToolBar()
            presenter.presentLoading(true)
            // fetch data
            fetchData()
        case .loadingError:
            if from == .loading {
                presenter.presentLoading(false)
            } else if from == .refreshing {
                // show alert maybe
            }
            let errorModel = ErrorMessageViewModel(title: LoadingErrorStrings.title, message: LoadingErrorStrings.message, buttonTittle: LoadingErrorStrings.actionTitle)
            presenter.presentError(errorModel)
            presenter.presentListToolBar()
        case .noContent:
            let noContentModel = ErrorMessageViewModel(title: NoContentErrorStrings.title, message: NoContentErrorStrings.message, buttonTittle: NoContentErrorStrings.actionTitle)
            presenter.presentError(noContentModel)
            presenter.presentListToolBar()
        case .refreshing:
            fetchData()
        case .hasContent:
            showCountersList()
        case .editing:
            presenter.presentEditToolbar()
        case .sharing:
            presenter.presentEditToolbar()
        }
    }
    
    private func fetchData() {
        
        let hasContent = [Counter(id: "0", title: "Cups of Coffee", count: 4),
                          Counter(id: "1", title: "Apples eaten", count: 2),
                          Counter(id: "2", title: "Water glasses", count: 8)]
        
//        let noContent: [Counter] = []
        // got error -> change state to error
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            self?.listState = .loadingError // -> OK to flow from loading   -  test the refreshing
//            self?.listState = .noContent   // -> OK
            
            self?.counters = hasContent
            self?.listState = .hasContent
            
        }
    }
    
    
    // MARK: - CountersListInteractorProtocol
    func start() {
        listState = .loading
    }
    
    private func showCountersList() {
        presenter.presentList(counters)
        presenter.presentListToolBar(countersCount: counters.count, countersSum: Counters.sum(counters))
    }
    
    func didPressErrorButton() {
        if listState == .loadingError {
            listState = .loading
        } else if listState == .noContent {
            // create a counter
            print("create a counter")
        }
    }
    
    func didPullToRefresh() {
        listState = .refreshing
    }

    func didEnterEditMode() {
        listState = .editing
    }
    
    
    func didChangeCounter(_ value: Int, at item: Int) {
        guard item < counters.count else { return }
        var counter = counters[item]
        counter.count = value
        showCountersList()
    }

    func didSelectCounter(_ at: Int) {
        guard counters.count > at else { return }
        counters[at].selected.toggle()
        showCountersList()
    }

    func selectAllCounters() {
        counters.forEach {$0.selected = true}
        showCountersList()
    }
    
    func deleteSelectedCounters() {
        self.counters = counters.filter({ $0.selected == false })
        showCountersList()
    }
    

}


