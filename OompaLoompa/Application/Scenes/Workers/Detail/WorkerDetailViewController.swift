//
//  WorkerDetailViewController.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 19/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit
import Haneke

class WorkerDetailViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: WorkerDetailPresenterProtocol!

    fileprivate let photoImageView = UIImageView()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()

        setup()

        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        view.addSubviewWithAutolayout(photoImageView)
        photoImageView.fillSuperview()
    }

    private func setup() {
        view.backgroundColor = .white
    }
}

extension WorkerDetailViewController: WorkerDetailUserInterfaceProtocol {

}

extension WorkerDetailViewController: ViewModelConfigurable {

    func configure(forViewModel vm: WorkerViewModel) {
        guard let url = URL(string: vm.imageURLPath) else {
            return
        }
        photoImageView.hnk_setImageFromURL(url, format: Format(name: "original"))
    }
}
