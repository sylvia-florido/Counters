//
//  CountersListViewController.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

protocol CountersListViewControllerProtocol: class {
    func displayLoading(_ visible: Bool)
    func displayError(_ viewModel: ErrorMessageViewModel)
    func displayList(_ viewModel: [CountersCellViewModel])
    func displayListToolBar(title: String)
    func displayEditToolbar()
    func displayEditButton(enabled: Bool)
    func switchDisplayMode(editing: Bool)
    func displayAddCounterScene()
}

class CountersListViewController: BaseViewController, CountersListViewControllerProtocol {
    
    var interactor: CountersListInteractorProtocol?
    var router: CountersRouterProtocol?
    
    lazy var errorMessageView: ErrorMessageView = {
        let view = ErrorMessageView.initFromNib()
        return view
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    private var customToolBar: CounterBottomToolbar = {
        let toolbar = CounterBottomToolbar(frame: .zero)
        toolbar.toolbarTitle = "4 items · Counted 16 times"
        return toolbar
    }()
    
    private lazy var listView: CountersListTableView = {
        let listView = CountersListTableView()
        listView.delegate = self
        return listView
    }()
        
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: - Lifecycle e Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.countersBackground
        
        title = "Counters"
        setupNavBars()
        setupView()
        setupSearch()
        interactor?.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    override func setupNavBars() {
        super.setupNavBars()
        
        navigationItem.leftBarButtonItem = editButtonItem
        toolbarItems = customToolBar.items
    }
    
    private func setupView() {
        view.addSubview(contentStackView)
        contentStackView.pin(to: view)
    }
    
    private func showView(_ view: UIView) {
        cleanView()
        contentStackView.addArrangedSubview(view)
    }
    
    private func cleanView() {
        contentStackView.subviews.forEach { (subview) in
            contentStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    //MARK: - Edit Feature
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        interactor?.didSwitchEditMode(editing: editing)
    }

    @objc func selectAllPressed(_ sender: Any?) {
        interactor?.selectAllCounters()
    }
    
    //MARK: - Search Feature
    private func setupSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    //MARK: - Add Feature
    func displayAddCounterScene() {
        router?.showAddCountersScene(with: self)
    }
    
    // MARK: - CountersListViewControllerProtocol
    // MARK: - Loading
    func displayLoading(_ visible: Bool) {
        if visible {
            showView(activityIndicatorView)
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
            cleanView()
        }
    }
    
    // MARK: - Error
    func displayError(_ viewModel: ErrorMessageViewModel) {
        errorMessageView.errorMessageState = .action(viewModel: viewModel, action: { [weak self] in
            self?.interactor?.didPressErrorButton()
        })
        showView(errorMessageView)
    }
    
    // MARK: - Listing Feature
    var viewModel: [CountersCellViewModel] = []

    func displayList(_ viewModel: [CountersCellViewModel]) {
        self.viewModel = viewModel
        listView.viewModel = viewModel
        showView(listView)
    }
    
    // MARK: - Edit Mode Feature
    func displayEditButton(enabled: Bool) {
        navigationItem.leftBarButtonItem?.isEnabled = enabled
    }

    func switchDisplayMode(editing: Bool) {
        if editing == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllPressed(_:)))
            listView.tableView.setEditing(true, animated: true)
        } else {
            navigationItem.rightBarButtonItem = nil
            listView.tableView.setEditing(false, animated: true)
        }
    }
    
    // MARK: - Toolbar
    func displayListToolBar(title: String) {
        customToolBar.toolbarState = .add(viewModel: ToolBarViewModel(toolbarTitle: title, leftAction: nil, righttAction: { [self] in
            interactor?.didPressAddButton()
        }))
    }
    
    func displayEditToolbar() {
        customToolBar.toolbarState = .edit(viewModel: ToolBarViewModel(toolbarTitle: nil, leftAction: { [weak self] in
            self?.interactor?.deleteSelectedCounters()
        }, righttAction: {
            // not enough time to implement
            print("Share")
        }))
    }
}


extension CountersListViewController: CountersListDelegate {
    func didStartRefreshing() {
        interactor?.didPullToRefresh()
    }
    
    func didChangeCounterValue(_ value: Int, at item: Int) {
        interactor?.didChangeCounter(value, at: item)
    }
    
    func didSelectCounter(_ at: Int) {
        interactor?.didSelectCounter(at)
    }
}


extension CountersListViewController: AddCounterInteractorDelegate {
    func didCreateNew(_ counter: Counter) {
        interactor?.didCreateNew(counter)
    }
}


extension CountersListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text, !text.isEmpty {
        filterContentForSearchText(text)
    } else {
        listView.viewModel = viewModel
    }
  }
    
    func filterContentForSearchText(_ searchText: String) {
         let filteredResults = viewModel.filter { (viewModel) -> Bool in
            return viewModel.title.lowercased().contains(searchText.lowercased())
        }
        listView.viewModel = filteredResults
    }
}
