//
//  Coordinator.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start(with deeplink: Deeplink?)
}

extension Coordinator {

    func add(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(coordinator child: Coordinator, from childCoordinators: inout [Coordinator]) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

protocol CoordinatorNavigationDelegate: AnyObject {
    func finished(_ coordinator: Coordinator)
}
