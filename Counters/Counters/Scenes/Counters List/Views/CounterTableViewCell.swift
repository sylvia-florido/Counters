//
//  CounterTableViewCell.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import UIKit

protocol CounterCellDelegate: class {
    func didChangeStepper(value: Int, at cell: UITableViewCell)
    func didSelectCell(_ cell: UITableViewCell)
}

class CounterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    weak var delegate: CounterCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        valueLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold, design: .rounded)
        selectionStyle = .none
        editingAccessoryType = .none
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        let insets: CGFloat = editing ? 4 : 0
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: insets, bottom: 0, right: insets)
        selectionButton.isHidden = !editing
    }
    
    func configWith(viewModel: CountersCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = String(viewModel.value)
        stepper.value = Double(viewModel.value)
        selectionButton.isSelected = viewModel.selected
    }
    
    // MARK: - Actions
    @IBAction func stepper(_ sender: UIStepper) {
        delegate?.didChangeStepper(value: Int(sender.value), at: self)
    }
    
    @IBAction func selectionButton(_ sender: UIButton) {
        delegate?.didSelectCell(self)
    }
}


