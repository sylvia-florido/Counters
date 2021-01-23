//
//  CounterBottomToolbar.swift
//  Counters
//
//  Created by Me on 21/01/21.
//

import UIKit


enum CustomToolbarState {
    case add(title: String, rightAction: (() -> Void))
    case edit(leftAction: (() -> Void), rightAction: (() -> Void))
}

class CounterBottomToolbar: UIToolbar {
    lazy var toolbarTitle: String = "" {
        didSet {
            titleLabel.text = toolbarTitle
            setup()
        }
    }
    
    var toolbarState: CustomToolbarState = .add(title: "", rightAction: {}) {
        didSet {
            setup()
        }
    }
        
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = Colors.darkSilver
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
        switch toolbarState {
        case .add(_, _):
            let title = UIBarButtonItem(customView: titleLabel)
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            setItems([spacer, title, spacer, add], animated: false)
            titleLabel.sizeToFit()
        case .edit(_, _):
            let delete = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: nil)
            let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            setItems([delete, spacer, share], animated: false)
        }
        backgroundColor = Colors.navBarGray
        tintColor = Colors.accentMainColor
    }


}
