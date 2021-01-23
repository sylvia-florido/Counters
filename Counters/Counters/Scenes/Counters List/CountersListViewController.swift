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
    func displayListToolBar(_ viewModel: ToolBarViewModel)
    func displayEditToolbar()
}

class CountersListViewController: BaseViewController, UISearchResultsUpdating, CountersListViewControllerProtocol {
    
    var interactor: CountersListInteractorProtocol?
    var router: CountersRouterProtocol?
    
    
    // warning for a title only OR action for title, message, button
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
        title = "Counters"
        setupNavBars()
        setupSearch()
        setupView()
        interactor?.start()
    }
    
    override func setupNavBars() {
        super.setupNavBars()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        navigationController?.toolbar.tintColor = Colors.accentMainColor
        navigationController?.isToolbarHidden = false
        toolbarItems = customToolBar.items

        edgesForExtendedLayout = UIRectEdge(arrayLiteral: [])
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
        interactor?.didEnterEditMode()
        if editing == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllPressed(_:)))
            listView.tableView.setEditing(true, animated: true)
        } else {
            navigationItem.rightBarButtonItem = nil
            listView.tableView.setEditing(false, animated: true)
        }
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
    
    func updateSearchResults(for searchController: UISearchController) {
        // Search
    }
    
    //MARK: - Add Feature

    
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
    
    // MARK: - List Counters
    func displayList(_ viewModel: [CountersCellViewModel]) {
        listView.viewModel = viewModel
        showView(listView)
    }
    
    // MARK: - Toolbar
    func displayListToolBar(_ viewModel: ToolBarViewModel) {
        customToolBar.toolbarTitle = viewModel.toolbarTitle
        customToolBar.toolbarState = .add(title: viewModel.toolbarTitle, rightAction: {
            // add
            print("Add")
        })
    }
    func displayEditToolbar() {
        customToolBar.toolbarState = .edit(leftAction: {
            // delete
            print("Delete")
        }, rightAction: {
            // share
            print("Share")
        })
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



