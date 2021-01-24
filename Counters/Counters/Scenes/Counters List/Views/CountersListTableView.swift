//
//  CountersListTableView.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import UIKit

protocol CountersListDelegate: class {
    func didChangeCounterValue(_ value: Int, at item: Int)
    func didSelectCounter(_ at: Int)
    func didStartRefreshing()
}

class CountersListTableView: UIView {
    
    var tableView: UITableView = UITableView(frame: .zero, style: .plain)
    var listState: CountersListState = .loading
    
    weak var delegate: CountersListDelegate?
    var viewModel: [CountersCellViewModel] = [] {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        addSubview(tableView)
        self.tableView.contentInsetAdjustmentBehavior = .never
        tableView.pin(to: self)
        setupTableView()
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        delegate?.didStartRefreshing()
    }
    
}


extension CountersListTableView: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func setupTableView() {
//        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
//        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = false
//        tableView.allowsMultipleSelection = true
//        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(CounterTableViewCell.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.count > indexPath.row else { return UITableViewCell() }
        let cellViewModel = viewModel[indexPath.row]
        let cell = tableView.dequeueCell(CounterTableViewCell.self, indexPath: indexPath)
        cell.configWith(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension CountersListTableView: CounterCellDelegate {
    func didChangeStepper(value: Int, at cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        delegate?.didChangeCounterValue(value, at: index)
    }
    
    func didSelectCell(_ cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else { return }
        delegate?.didSelectCounter(index)
    }
    
    
}
