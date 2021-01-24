//
//  BaseViewController.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    /// Use this outlet to set the 'UIScrollView' to have its insets automatically adjusted for the keyboard frame.
    @IBOutlet public weak var formScrollView: UIScrollView?
    
    /// Override this property to allow `SantanderBaseViewController` to automatically adjusts scroll view insets for the keyboard frame.
    open var automaticallyAdjustsScrollViewInsetsForKeyboard: Bool {
        return false
    }
    
    //MARK: Constructors
    func setupNavBars() {
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.backgroundColor = Colors.navBarGray
        appearanceNavBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearanceNavBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.view.backgroundColor = Colors.countersBackground
        
        navigationController?.navigationBar.standardAppearance = appearanceNavBar
        navigationController?.navigationBar.compactAppearance = appearanceNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNavBar
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Colors.accentMainColor
        
        let appearanceToolBar = UIToolbarAppearance()
        appearanceToolBar.backgroundColor = Colors.navBarGray
        appearanceToolBar.backgroundImageContentMode = .scaleAspectFit
        
        navigationController?.toolbar.standardAppearance = appearanceToolBar
        navigationController?.toolbar.compactAppearance = appearanceToolBar

        navigationController?.toolbar.tintColor = Colors.accentMainColor

        edgesForExtendedLayout = UIRectEdge(arrayLiteral: [])
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    
    //MARK: Lifecycle
    @objc override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.countersBackground
        setupNavBars()
        if automaticallyAdjustsScrollViewInsetsForKeyboard && formScrollView == nil {
            formScrollView = rootScrollView()
        }
    }
    
    @objc open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if automaticallyAdjustsScrollViewInsetsForKeyboard {
            registerForKeyboardNotifications()
        }
    }
    
    @objc open override func viewDidDisappear(_ animated: Bool) {
        if automaticallyAdjustsScrollViewInsetsForKeyboard {
            unregisterForKeyboardNotifications()
        }
        super.viewDidDisappear(animated)
    }

    
    // MARK: - Keyboard handling
    @objc func registerForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func unregisterForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc open func keyboardWillShowNotification(_ notification: Notification) {
        let keyboardInfo = notification.userInfo
        let keyboardFrame = keyboardInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        if let keyboardHeight = keyboardFrame?.height, let scrollView = formScrollView {
            var bottomInset = keyboardHeight
            if #available(iOS 11, *) {
                bottomInset -= scrollView.safeAreaInsets.bottom
            }
            let edgeInsets = UIEdgeInsets(top: scrollView.contentInset.top,
                                          left: scrollView.contentInset.left,
                                          bottom: bottomInset,
                                          right: scrollView.contentInset.right)
            scrollView.contentInset = edgeInsets
            scrollView.scrollIndicatorInsets = edgeInsets
        }
    }
    
    @objc open func keyboardWillHideNotification(_ notification: Notification) {
        guard let scrollView = formScrollView else { return }
        let edgeInsets = UIEdgeInsets(top: scrollView.contentInset.top,
                                      left: scrollView.contentInset.left,
                                      bottom: 0.0,
                                      right: scrollView.contentInset.right)
        scrollView.contentInset = edgeInsets
        scrollView.scrollIndicatorInsets = edgeInsets
    }
    
    private func rootScrollView() -> UIScrollView? {
        return view.subviews.first(where: { subview in subview is UIScrollView }) as? UIScrollView
    }
}
