//
//  NSLayoutConstraint+Utils.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

public extension UIView {
    func pinToEdge(_ view: UIView, constant: CGFloat = 0) {
        let guide: UILayoutGuide
        if #available(iOS 11.0, *) {
            guide = view.safeAreaLayoutGuide
        } else {
            guide = view.layoutMarginsGuide
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: guide.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -constant),
            leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -constant)
            ])
    }

    func pinToEdge(_ view: UIView, insets: UIEdgeInsets) {
        let guide: UILayoutGuide
        if #available(iOS 11.0, *) {
            guide = view.safeAreaLayoutGuide
        } else {
            guide = view.layoutMarginsGuide
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: guide.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -insets.right)
            ])
    }

    func pinToCenter(_ view: UIView) {
        let guide: UILayoutGuide
        if #available(iOS 11.0, *) {
            guide = view.safeAreaLayoutGuide
        } else {
            guide = view.layoutMarginsGuide
        }

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            centerYAnchor.constraint(equalTo: guide.centerYAnchor)
            ])
    }
}
