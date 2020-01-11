//
//  DetailMeteoCoordinator.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

final class DetailMeteoCoordinator: NSObject, Coordinator {

    var childCoordinators: [Coordinator] = []

    private(set) var currentController: MainViewController!

    let navigationController: UINavigationController

    weak var coordinatorDelegate: CoordinatorNavigationDelegate?

    private let meteoItem: ForeCastMeteo

    init(navigationController: UINavigationController, meteoItem: ForeCastMeteo) {
        self.navigationController = navigationController
        self.meteoItem = meteoItem
    }

    func start(with deeplink: Deeplink?) {
        showDetailMeteoView()
    }
}

private extension DetailMeteoCoordinator {
    func showDetailMeteoView() {
        let viewModel = DetailMeteoViewModelImpl(meteo: meteoItem)
        viewModel.delegate = self
        let vc = DetailMeteoViewController(coordinator: self, viewModel: viewModel)
        currentController = vc
        navigationController.pushViewController(vc, animated: true)
        navigationController.delegate = self
    }
}

extension DetailMeteoCoordinator: DetailMeteoViewModelDelegate {
    func close() {
        navigationController.popViewController(animated: true)
        coordinatorDelegate?.finished(self)
    }
}

extension DetailMeteoCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            let toViewController =
            navigationController.transitionCoordinator?.viewController(forKey: .to) else {
                return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if
            fromViewController is DetailMeteoViewController,
            toViewController is HomeViewController {
            coordinatorDelegate?.finished(self)
        }
    }
}
