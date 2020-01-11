//
//  AppCoordinator.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []

    let tabBarController: UITabBarController = UITabBarController()

    private let window: UIWindow?

    init(window: UIWindow?, notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.window = window
        AppCoordinator.setupStyles()
    }

    func start(with deeplink: Deeplink?) {
        showHome(with: deeplink)
    }
}

private extension AppCoordinator {

    func showHome(with deeplink: Deeplink?) {
        setupTabBarController(with: deeplink)
    }
    func setupTabBarController(with deeplink: Deeplink?) {

        let home = HomeCoordinator(navigationController: UINavigationController())
        home.start(with: deeplink)
        tabBarController.viewControllers = [home.navigationController]
        add(home)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    static func setupStyles() {
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: StyleSheet.Color.highlight]
        } else {
            // Fallback on earlier versions
        }
    }
}
