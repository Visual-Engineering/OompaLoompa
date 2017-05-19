//
//  WorkerDetailBuilder.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 19/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
//import Deferred

protocol WorkerDetailPresenterProtocol {
    func viewDidLoad()
}

protocol WorkerDetailInteractorProtocol {
    //    func retrieveData() -> Task<WorkerDetailViewModel>
}

protocol WorkerDetailUserInterfaceProtocol {

}

class WorkerDetailBuilder {

    //MARK: - Configuration
    static func build(withViewModel vm: WorkerViewModel) -> WorkerDetailViewController {
        let viewController = WorkerDetailViewController()
        let router = WorkerDetailRouter(view: viewController)
        let interactor = WorkerDetailInteractor()
        let presenter = WorkerDetailPresenter(router: router, interactor: interactor, view: viewController, viewModel: vm)

        viewController.presenter = presenter

        return viewController
    }
}
