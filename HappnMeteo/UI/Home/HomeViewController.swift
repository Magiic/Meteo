//
//  HomeViewController.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

final class HomeViewController: MainViewController {

    let viewModel: HomeViewModel
    weak var coordinator: Coordinator?
    var stateView: EmptyStateViewable? = nil

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "table_view"
        tableView.register(cellClass: MeteoDayTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    init(coordinator: Coordinator, viewModel: HomeViewModel) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

}

private extension HomeViewController {

    func setup() {
        title = "home".translated().uppercased()
        view.accessibilityIdentifier = "home"
        setupInterface()
        addConstraints()
        viewModel.refresh = { [weak self] in
            self?.tableView.reloadData()
            self?.addEmptyStateView()
        }

        if viewModel.items.isEmpty {
            addEmptyStateView()
        }
    }

    func setupInterface() {
        view.addSubview(tableView)
    }

    func addConstraints() {
        let guide: UILayoutGuide
        if #available(iOS 11.0, *) {
            guide = view.safeAreaLayoutGuide
        } else {
            guide = self.view.layoutMarginsGuide
        }
        let constant: CGFloat = 0
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -constant),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: constant),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -constant)
            ])
    }

    func addEmptyStateView() {
        if viewModel.items.isEmpty {
            let state: EmptyState = EmptyStateDefault(
                title: "empty_state_meteo_title".translated(),
                message: "empty_state_meteo_message".translated(),
                picture: StyleSheet.Icon.emptyHome,
                action: nil)

            showEmptyState(state)
        } else {
            dismissEmptyState()
        }
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: MeteoDayTableViewCell.self, for: indexPath)
        cell.configure(item: viewModel.items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(item: viewModel.items[indexPath.row])
    }
}

extension HomeViewController: EmptyStatable {}
