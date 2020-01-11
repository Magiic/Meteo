//
//  EmptyStateView.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

protocol EmptyStateViewable: UIView {
    var state: EmptyState { get set }
}

final class EmptyStateView: UIView, EmptyStateViewable {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "title_label"
        label.numberOfLines = 3
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = StyleSheet.Color.primaryText
        label.textAlignment = .center
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "title_label"
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = StyleSheet.Color.primaryText
        label.textAlignment = .center
        return label
    }()

    lazy var actionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: .tapButton, for: .touchUpInside)
        button.setTitleColor(.white, for: [])
        button.backgroundColor = StyleSheet.Color.highlight
        button.contentEdgeInsets = .init(top: 25, left: 25, bottom: 25, right: 25)
        button.layer.cornerRadius = 20
        return button
    }()

    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = StyleSheet.Icon.emptyHome
        imageView.tintColor = StyleSheet.Color.highlight
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "container_stackView"
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()

    var state: EmptyState

    init(state: EmptyState) {
        self.state = state
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    fileprivate func didTapButton() {
        state.action?.1()
    }

}

private extension EmptyStateView {

    func setup() {
        accessibilityIdentifier = "empty_state_view"
        self.addSubview(stackView)
        stackView.addArrangedSubview(pictureImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(actionButton)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 14),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -14),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 14),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -14),

            pictureImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            pictureImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),

            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        titleLabel.text = state.title
        pictureImageView.image = state.picture
        messageLabel.text = state.message
        actionButton.isHidden = state.action == nil
        if let action = state.action {
            actionButton.setTitle(action.0, for: [])
        }
    }
}

private extension Selector {
    static let tapButton = #selector(EmptyStateView.didTapButton)
}
