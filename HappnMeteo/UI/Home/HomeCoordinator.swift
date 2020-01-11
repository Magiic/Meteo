//
//  HomeCoordinator.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

final class HomeCoordinator: NSObject, Coordinator {

    var childCoordinators: [Coordinator] = []

    private(set) var currentController: MainViewController!

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start(with deeplink: Deeplink?) {
        showHome()
    }
}

fileprivate extension HomeCoordinator {
    func showHome() {
        let viewModel = HomeViewModelImpl(service: ForecastMeteoServiceImpl())
        viewModel.delegate = self
        let home = HomeViewController(coordinator: self, viewModel: viewModel)
        let unselectedImage = StyleSheet.Icon.TabBar.home
        let selectedImage = unselectedImage.withRenderingMode(.alwaysTemplate)
        home.tabBarItem = UITabBarItem(title: nil, image: unselectedImage, tag: 0)
        home.tabBarItem.selectedImage = selectedImage
        currentController = home
        navigationController.viewControllers = [home]
    }
}

// MARK: - DetailViewModelDelegate

extension HomeCoordinator: CoordinatorNavigationDelegate {
    func finished(_ coordinator: Coordinator) {
        remove(coordinator: coordinator, from: &childCoordinators)
    }
}

// MARK: - HomeViewModelDelegate

extension HomeCoordinator: HomeViewModelDelegate {

    func showDetail(meteoDay: ForeCastMeteo) {
        let coordinator = DetailMeteoCoordinator(navigationController: navigationController, meteoItem: meteoDay)
        coordinator.coordinatorDelegate = self
        add(coordinator)
        coordinator.start(with: nil)
    }
}
