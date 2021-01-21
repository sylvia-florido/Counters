//
//  CounterBottomToolbar.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import UIKit

class CounterBottomToolbar: UIToolbar {
    lazy var toolbarTitle: String = "" {
        didSet {
            titleLabel.text = toolbarTitle
        }
    }
        
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = Colors.darkSilver
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
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
  
    func setup() {
        let title = UIBarButtonItem(customView: titleLabel)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        setItems([spacer, title, spacer, add], animated: false)
    }
}
