//
//  MainViewController.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Orientation

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStyleBackgroundView()
    }

    // MARK: - Style
    
    func setupStyleBackgroundView() {

        guard let tabBar = self.tabBarController?.tabBar else { return }

        tabBar.tintColor = StyleSheet.Color.highlight
        tabBar.barTintColor = StyleSheet.Color.primaryBack
        tabBar.unselectedItemTintColor = StyleSheet.Color.primaryText

        view.backgroundColor = StyleSheet.Color.primaryBack
    }
}
