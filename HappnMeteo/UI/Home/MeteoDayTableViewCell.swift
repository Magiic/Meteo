//
//  MeteoDayTableViewCell.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

final class MeteoDayTableViewCell: UITableViewCell {

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "day_label"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = StyleSheet.Color.primaryText
        label.textAlignment = .left
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "temperature_label"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = StyleSheet.Color.secondaryText
        label.textAlignment = .right
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "meteo_icon"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "stackview"
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: MeteoDayItem) {
        self.dayLabel.text = item.day
        self.temperatureLabel.text = item.meanTemperature.celciusTemp
        guard let iconName = item.iconPathURL, let url = APIIcon.buildURL(with: iconName) else { return }
        self.iconImageView.downloadImage(withURL: url, completion: nil)
    }

}

private extension MeteoDayTableViewCell {

    func setup() {
        accessibilityIdentifier = "meteo_day_cell"
        setupInterface()
        addConstraints()
    }

    func setupInterface() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(temperatureLabel)
    }

    func addConstraints() {
        let heightIcon = iconImageView.heightAnchor.constraint(equalToConstant: 25)
        heightIcon.priority = .init(rawValue: 999)
        let widthIcon = iconImageView.widthAnchor.constraint(equalToConstant: 25)
        widthIcon.priority = .init(rawValue: 999)
        
        NSLayoutConstraint.activate([
            heightIcon,
            widthIcon,

            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
