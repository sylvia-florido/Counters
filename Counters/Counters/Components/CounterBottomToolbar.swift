//
//  CounterBottomToolbar.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import UIKit


enum CustomToolbarState {
    case add(viewModel: ToolBarViewModel)
    case edit(viewModel: ToolBarViewModel)
}

class CounterBottomToolbar: UIToolbar {
    lazy var toolbarTitle: String = "" {
        didSet {
            titleLabel.text = toolbarTitle
            updateViews()
        }
    }
    
    var toolbarState: CustomToolbarState = .add(viewModel: ToolBarViewModel(toolbarTitle: nil, leftAction: nil, righttAction: nil)) {
        didSet {
            configureViewModel()
            updateViews()
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = " "
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = Colors.darkSilver
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var customView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftButton, titleLabel, rightButton])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.frame = frame
        return stack
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonPressed), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(rightButtonPressed(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return button
    }()
    
    convenience init(title: String) {
        self.init(frame: .zero)
        toolbarTitle = title
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let custom = UIBarButtonItem(customView: customView)
        setItems([custom], animated: false)
    }
    
    private func updateViews() {
        switch toolbarState {
        case .add(let viewModel):
            leftButton.alpha = 0
            rightButton.setImage(UIImage(systemName: "plus"), for: .normal)
        case .edit(let viewModel):
            leftButton.alpha = 1
            rightButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        }
        
        backgroundColor = Colors.navBarGray
        tintColor = Colors.accentMainColor
    }
    
    private func configureViewModel() {
        switch toolbarState {
        case .add(let viewModel), .edit(let viewModel):
            titleLabel.text = viewModel.toolbarTitle ?? " "
            leftAction = viewModel.leftAction
            rightAction = viewModel.righttAction
        }
    }
    
    var leftAction: (() -> Void)?
    var rightAction: (() -> Void)?
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        leftAction?()
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
       rightAction?()
    }
}
