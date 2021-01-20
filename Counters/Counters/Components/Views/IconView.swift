//
//  IconView.swift
//  Counters
//
//  Created by Me on 19/01/21.
//

import UIKit

@IBDesignable
class IconView: BaseView {
   
    //MARK: -  Properties
    @IBInspectable public var imageName: String? = nil {
        didSet {
            guard let name = imageName else { return }
            let image = UIImage(named: name, in: Bundle(for: IconView.self), compatibleWith: nil)
            icon.image = image
        }
    }
    
    @IBInspectable public var accessibleTitle: String? {
        didSet {
            setupAccessibility()
        }
    }
    
    //MARK: -  Subviews
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.tintColor = .systemBackground
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init / Setup
    init(cornerRadius: CGFloat = 10.0, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear, frame: CGRect = .zero, imageName: String? = nil) {
        super.init(cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor, frame: frame)
        self.imageName = imageName
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
    
    override func setup() {
        super.setup()
        if let imageName = imageName {
            icon.image = UIImage(named: imageName, in: Bundle(for: IconView.self), compatibleWith: nil)
        }
        addSubview(icon)
        icon.center(to: self, minPadding: 6)
        borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        borderWidth = 1.0
        setupAccessibility()
    }
    
    private func setupAccessibility() {
        guard let title = accessibleTitle else { return }
        self.accessibilityLabel = title
        self.accessibilityTraits = .image
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
