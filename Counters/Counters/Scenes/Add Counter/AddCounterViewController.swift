//
//  AddCounterViewController.swift
//  Counters
//
//  Created by Me on 23/01/21.
//

import UIKit

protocol AddCounterInteractorDelegate: class {
    func didCreateNew(_ counter: Counter)
}

protocol AddCounterViewControllerProtocol: class {
    func displaySubtitle(_ text: NSAttributedString)
    func displayPlaceholder(_ text: String)
    func displayActivityIndicator(_ visible: Bool)
    func displaySaveOption(_ enabled: Bool)
    func displayCountersListScene(with counter: Counter?)
    func displayAlert(title: String, message: String, buttonTitle: String)
}

class AddCounterViewController: BaseViewController, AddCounterViewControllerProtocol {
    var interactor: AddCounterInteractorProtocol?
    var router: CountersRouterProtocol?
    weak var delegate: AddCounterInteractorDelegate?

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override var automaticallyAdjustsScrollViewInsetsForKeyboard: Bool {
        return true
    }
    
    //MARK: - Lifecycle
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
    }
    func displaySubtitle(_ text: NSAttributedString) {
        subtitleLabel.attributedText = text
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
    
    override func setupNavBars() {
        super.setupNavBars()
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont.preferredFont(forTextStyle: .headline)], for: UIControl.State.normal)
        rightBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:  UIColor.systemGray3], for: UIControl.State.disabled)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationController?.isToolbarHidden = true

    }
    
    //MARK: - Cancel
    @objc func cancelAction(_ sender: Any?) {
        interactor?.didPressCancelButton()
    }
    
    //MARK: - Save
    @objc func saveAction(_ sender: Any?) {
        interactor?.didPressSaveButton(with: textview.text)
    }
    
    //MARK: - Examples
    @IBAction func examplesButton(_ sender: UIButton) {
        // To be implemented. Not enough time, sorry :)
    }
    
    // MARK: - AddCounterViewControllerProtocol
    //MARK: - Save Feature
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
        navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
    
    func displayCountersListScene(with counter: Counter?) {
        if let counter = counter {
            delegate?.didCreateNew(counter)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func displayAlert(title: String, message: String, buttonTitle: String) {
        UIAlertController.show(from: self, title: title, message: message, preferredButtonTitle: buttonTitle) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
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
