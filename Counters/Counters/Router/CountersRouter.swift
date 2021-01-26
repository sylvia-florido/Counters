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
    func showAddCountersScene(with delegate: AddCounterInteractorDelegate)
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
        let controller = CountersListViewController()
        let presenter = CountersListPresenter(with: controller)
        let interactor = CountersListInteractor(with: presenter, repository: repository)
        controller.interactor = interactor
        controller.router = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showAddCountersScene(with delegate: AddCounterInteractorDelegate) {
        let controller = AddCounterViewController()
        let presenter = AddCounterPresenter(with: controller)
        let interactor = AddCounterInteractor(with: presenter, repository: repository)
        controller.interactor = interactor
        controller.router = self
        controller.delegate = delegate
        navigationController.pushViewController(controller, animated: true)
    }
}
