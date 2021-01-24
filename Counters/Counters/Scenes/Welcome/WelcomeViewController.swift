//
//  WelcomeViewController.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

protocol WelcomeViewControllerProtocol: class {
    func displayTitle(_ title: NSMutableAttributedString)
    func routeToCountersListScene()
}

class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var interactor: WelcomeInteractorProtocol?
    var router: CountersRouterProtocol?
    
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewdidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction func continueButton(_ sender: UIButton) {
        interactor?.continueButtonPressed()
    }
    
    
    // MARK: - WelcomeViewControllerProtocol
    func displayTitle(_ title: NSMutableAttributedString) {
        titleLabel.attributedText = title
    }

    func routeToCountersListScene() {
        router?.showCountersListScene()
    }
}
