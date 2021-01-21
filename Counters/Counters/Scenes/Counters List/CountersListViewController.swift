//
//  CountersListViewController.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

struct ListViewModel {
    let toolBarText: String
}

class CountersListViewController: BaseViewController, UISearchResultsUpdating {
    
    // warning for a title only OR action for title, message, button
    lazy var errorMessageView: ErrorMessageView = {
        let view = ErrorMessageView.initFromNib()
        view.errorMessageState = .warning(message: "No Results")
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
    
    //MARK: - Lifecycle e Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Counters"
        setupNavBars()
        setupSearch()
        
        // test activity view
//        view.addSubview(activityIndicatorView)
//        activityIndicatorView.center(to: view, minPadding: 20)
//        activityIndicatorView.startAnimating()
        
        
        // test errorMessageView
//        view.addSubview(errorMessageView)
//        errorMessageView.pin(to: view)
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

    //MARK: - Edit Feature
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing == true {
            // edit thing
        } else {
            // finish editing
        }
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

}
