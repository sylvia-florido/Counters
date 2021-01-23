//
//  CountersListPresenter.swift
//  Counters
//
//  Created by Me on 22/01/21.
//

import Foundation

protocol CountersListPresenterProtocol {
    func presentLoading(_ visible: Bool)
    func presentError(_ viewModel: ErrorMessageViewModel)
    func presentList(_ model: [Counter])
    func presentListToolBar(countersCount: Int?, countersSum: Int?)
    func presentEditToolbar()
    func presentDisplayMode(editing: Bool)

}

class CountersListPresenter: CountersListPresenterProtocol {
    weak var controller: CountersListViewControllerProtocol?
    
    init(with controller: CountersListViewControllerProtocol) {
        self.controller = controller
    }
    
    func presentLoading(_ visible: Bool) {
        controller?.displayLoading(visible)
    }
    
    func presentError(_ viewModel: ErrorMessageViewModel) {
        controller?.displayError(viewModel)
    }
    
    func presentList(_ model: [Counter]) {
        let viewModel = model.map { (counter) -> CountersCellViewModel in
            CountersCellViewModel(title: counter.title, value: counter.count, selected: counter.selected)
        }
        controller?.displayList(viewModel)
    }
    
    func presentListToolBar(countersCount: Int? = nil, countersSum: Int? = nil) {
        guard let count = countersCount, let sum = countersSum else {
            controller?.displayListToolBar(title: " ")
            return
        }
        let itemText = count < 2 ? "item" : "items"
        let title = "\(count) \(itemText) · Counted \(sum) times"
        controller?.displayListToolBar(title: title)
    }
    
    func presentEditToolbar() {
        controller?.displayEditToolbar()
    }
    
    func presentDisplayMode(editing: Bool) {
        controller?.switchDisplayMode(editing: editing)
    }
}
