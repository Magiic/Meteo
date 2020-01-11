//
//  DetailMeteoViewController.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

final class DetailMeteoViewController: MainViewController {

    private let viewModel: DetailMeteoViewModel
    weak var coordinator: Coordinator?

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "city_label"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 75)
        label.textColor = StyleSheet.Color.primaryText
        label.textAlignment = .center
        label.text = viewModel.cityName
        return label
    }()

    private lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "description_label"
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = StyleSheet.Color.primaryText
        label.textAlignment = .center
        label.text = viewModel.descriptionWeather
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "temperature_label"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 75)
        label.textColor = StyleSheet.Color.primaryText
        label.textAlignment = .center
        label.text = viewModel.temperature
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "meteo_icon"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "header_stackview"
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()

    init(coordinator: Coordinator, viewModel: DetailMeteoViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension DetailMeteoViewController {

    func setup() {
        view.accessibilityIdentifier = "detail"
        setupInterface()
        addConstraints()
        fetchIcon()
    }

    func setupInterface() {
        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(cityLabel)
        headerStackView.addArrangedSubview(weatherDescriptionLabel)
        headerStackView.addArrangedSubview(iconImageView)
        headerStackView.addArrangedSubview(temperatureLabel)
        if #available(iOS 11.0, *) {
            headerStackView.setCustomSpacing(18, after: iconImageView)
        }
    }

    func addConstraints() {
        let guide: UILayoutGuide
        if #available(iOS 11.0, *) {
            guide = view.safeAreaLayoutGuide
        } else {
            guide = view.layoutMarginsGuide
        }

        let heightIcon = iconImageView.heightAnchor.constraint(equalToConstant: 100)
        heightIcon.priority = .init(rawValue: 999)
        let widthIcon = iconImageView.widthAnchor.constraint(equalToConstant: 100)
        widthIcon.priority = .init(rawValue: 999)

        NSLayoutConstraint.activate([
            heightIcon,
            widthIcon,

            headerStackView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            headerStackView.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 10),
            headerStackView.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -10),
            headerStackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            headerStackView.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor, constant: -30)
        ])
    }

    func fetchIcon() {
        guard let iconName = viewModel.iconPathURL, let url = APIIcon.buildURL(with: iconName) else { return }
        iconImageView.downloadImage(withURL: url, completion: nil)
    }
}
