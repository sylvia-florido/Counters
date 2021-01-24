//
//  AddCounterViewController.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import UIKit
protocol AddCounterViewControllerProtocol: class {
    func displayPlaceholder(_ text: String)
    func displayActivityIndicator(_ visible: Bool)
    func displaySaveOption(_ enabled: Bool)
    func displayCancelAction()
}

class AddCounterViewController: BaseViewController, AddCounterViewControllerProtocol {
    var interactor: AddCounterInteractorProtocol?
    var router: CountersRouterProtocol?
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override var automaticallyAdjustsScrollViewInsetsForKeyboard: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = Colors.countersBackground
        UITextView.appearance().tintColor = Colors.accentMainColor
        title = "Create a counter"
        setupNavBars()
        textview.delegate = self
        textview.textContainer.maximumNumberOfLines = 5
        textview.textContainer.lineBreakMode = .byTruncatingTail
        interactor?.start()
        setAttributedText()
    }
    
    func setAttributedText() {
        let text = "Give it a name. Creative block? See examples."
        let attributedText = text.getAttributedString()
        //           attributedText.apply(color: .red, subString: "This")
        //           attributedText.apply(font: UIFont.boldSystemFont(ofSize: 24), subString: "This")
        attributedText.underLine(subString: "examples")
        //           attributedText.applyShadow(shadowColor: .black, shadowWidth: 4.0, shadowHeigt: 4.0, shadowRadius: 4.0, subString: "attributedString")
        subtitleLabel.attributedText = attributedText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    let leftBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
    
    let rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        button.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont.preferredFont(forTextStyle: .headline)], for: UIControl.State.normal)
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:  UIColor.systemGray3], for: UIControl.State.disabled)
        return button
    }()
    
    override func setupNavBars() {
        super.setupNavBars()
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont.preferredFont(forTextStyle: .headline)], for: UIControl.State.normal)
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:  UIColor.systemGray3], for: UIControl.State.disabled)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func cancelAction(_ sender: Any?) {
        interactor?.didPressCancelButton()
    }
    
    @objc func saveAction(_ sender: Any?) {
        interactor?.didPressSaveButton(with: textview.text)
    }
    
    // MARK: - AddCounterViewControllerProtocol
    func displayPlaceholder(_ text: String) {
        textview.text = text
        textview.textColor = text.isEmpty ? UIColor.label : UIColor.systemGray3
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func displayActivityIndicator(_ visible: Bool) {
        activityIndicator.isHidden = !visible
        visible == true ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func displaySaveOption(_ enabled: Bool) {
        rightBarButton.isEnabled = enabled
    }
    
    func displayCancelAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddCounterViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        interactor?.didBeginEditing()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        interactor?.didChange(text: textview.text)
    }
    
}

