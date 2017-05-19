//
//  WorkerListViewController.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class WorkerListViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: WorkerListPresenterProtocol!

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.register(WorkerListCell.self, forCellReuseIdentifier: WorkerListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        return tableView
    }()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()

        title = "Oompa Loompa workers"

        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        view.addSubviewWithAutolayout(tableView)
        tableView.fillSuperview()
    }
}

extension WorkerListViewController: WorkerListUserInterfaceProtocol {

    func reloadTableView() {
        tableView.reloadData()
    }

    func showActivityIndicator() {
        let activityData = ActivityData(message: "Cargando",
                                        messageFont: UIFont.systemFont(ofSize: 16.0),
                                        type: .ballRotateChase,
                                        backgroundColor: UIColor.black.withAlphaComponent(0.2))

        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    func dismissActivityIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

extension WorkerListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = presenter.element(at: indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: WorkerListCell.reuseIdentifier, for: indexPath) as? WorkerListCell else {
            return UITableViewCell()
        }

        cell.configure(forViewModel: element)

        return cell
    }
}

extension WorkerListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        presenter.didSelectElement(at: indexPath.row)
    }

}
