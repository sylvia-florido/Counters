//
//  CountersRouter.swift
//  Counters
//
//  Created by Me on 20/01/21.
//

import UIKit

protocol CountersRouterProtocol {
    func start()
    func showWelcomeScene()
    func showCountersListScene()
}

class CountersRouter: CountersRouterProtocol {
    var navigationController: UINavigationController
    var repository: CountersRepository = CountersRepository()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showWelcomeScene()
    }
    
    func showWelcomeScene() {
        let controller = WelcomeViewController()
        let presenter = WelcomePresenter(with: controller)
        let interactor = WelcomeInteractor(with: presenter, repository: repository)
        controller.interactor = interactor
        controller.router = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showCountersListScene() {
        print("Show list")
    }
}