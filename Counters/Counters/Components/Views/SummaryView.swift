//
//  SummaryView.swift
//  Counters
//
//  Created by Me on 19/01/21.
//

import UIKit

@IBDesignable
class SummaryView: UIView {
    
    //MARK: -  Properties
    @IBInspectable public var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
            self.accessibilityLabel = self.title
        }
    }
    
    @IBInspectable public var subtitle: String = "" {
        didSet {
            self.subtitleLabel.text = self.subtitle
            self.accessibilityValue = self.subtitle
        }
    }
    
    @IBInspectable public var iconName: String? {
        didSet {
            iconView.imageName = iconName
        }
    }
    
    @IBInspectable public var iconColor: UIColor? {
        didSet {
            iconView.backgroundColor = iconColor
        }
    }
    
    @IBInspectable public var accessibleTitle: String?
    
    @IBInspectable public var verticalSpacing: CGFloat = 0 {
        didSet {
            verticalStackView.spacing = max(0, verticalSpacing)
        }
    }
    
    // MARK: - Subviews
    private lazy var titleLabel: BaseLabel = {
        let label = BaseLabel(textStyle: UIFont.TextStyle.headline)
        label.textColor = UIColor.label
        label.text = self.title
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var subtitleLabel: BaseLabel = {
        let label = BaseLabel(textStyle: UIFont.TextStyle.body)
        label.textColor = Colors.subtitleDarkGray
        label.text = self.subtitle
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return stackView
    }()
    
    
    private lazy var iconView: IconView = {
        let iconView = IconView(cornerRadius: 10.0, imageName: iconName)
        iconView.imageName = iconName
        iconView.backgroundColor = iconColor
        iconView.heightAnchor.constraint(equalToConstant: 49.0).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 49.0).isActive = true
        iconView.setContentHuggingPriority(.required, for: .vertical)
        iconView.setContentHuggingPriority(.required, for: .horizontal)
        return iconView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.iconView, self.verticalStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.required, for: .vertical)
        return stackView
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
    
    public init(imageName: String, title: String, subtitle: String, titleStyle: UIFont.TextStyle = .headline, subtitleStyle: UIFont.TextStyle = .body, alignment:NSTextAlignment = .left, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.iconName = imageName
        self.title = title
        self.subtitle = subtitle
        self.titleLabel.textStyle = titleStyle
        self.subtitleLabel.textStyle = subtitleStyle
        self.setup()
    }
    
    private func setup() {
        self.addSubview(self.horizontalStackView)
        self.iconView.imageName = iconName
        self.iconView.backgroundColor = iconColor
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        horizontalStackView.pin(to: self)
        setupAccesibility()
    }
    
    private func setupAccesibility() {
        self.isAccessibilityElement = true
        self.accessibilityTraits = .staticText
        self.accessibilityLabel = self.accessibleTitle ?? "\(title)\(subtitle)"
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

