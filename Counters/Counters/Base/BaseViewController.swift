//
//  BaseViewController.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.countersListBackground
        setupNavBars()
    }
    
    func setupNavBars() {
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.backgroundColor = Colors.navBarGray
        appearanceNavBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearanceNavBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
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
    
}
