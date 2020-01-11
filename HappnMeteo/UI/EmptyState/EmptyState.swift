//
//  EmptyState.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

protocol EmptyState {
    var title: String? { get }
    var message: String? { get }
    var picture: UIImage? { get }
    var action: (String, () -> Void)? { get set }
}

struct EmptyStateDefault: EmptyState {

    var title: String?

    var message: String?

    var picture: UIImage?

    var action: (String, () -> Void)?
}

protocol EmptyStatable: AnyObject {
    var stateView: EmptyStateViewable? { get set }
}

extension EmptyStatable where Self: UIViewController {

    func showEmptyState(_ state: EmptyState) {
        guard stateView == nil else {
            stateView?.state = state
            return
        }

        stateView = EmptyStateView(state: state)
        self.view.addSubview(stateView!)
        stateView?.translatesAutoresizingMaskIntoConstraints = false

        stateView?.pinToEdge(self.view)
    }

    func dismissEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.stateView?.removeFromSuperview()
        }
    }
}
