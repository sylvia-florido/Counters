//
//  WelcomeViewController.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

protocol WelcomeViewControllerProtocol: class {
    func routeToCountersListScene()
}

class WelcomeViewController: UIViewController, WelcomeViewControllerProtocol {
    
    var interactor: WelcomeInteractorProtocol?
    var router: CountersRouterProtocol?
    
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func routeToCountersListScene() {
        router?.showCountersListScene()
    }
}
