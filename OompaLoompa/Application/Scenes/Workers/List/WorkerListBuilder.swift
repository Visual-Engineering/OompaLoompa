//
//  WorkerListBuilder.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import OompaLoompaCore

protocol WorkerListPresenterProtocol {
    func viewDidLoad()
    func numberOfRows() -> Int
    func element(at index: Int) -> WorkerViewModel?
    func didSelectElement(at index: Int)
    func didFilter(withText text: String)
    func didRefresh(withFilter text: String, completion: @escaping (Void) -> Void)
}

protocol WorkerListInteractorProtocol {
    func retrieveData(withFilter filter: String, invalidateCache: Bool) -> Task<[WorkerModel]>
}

protocol WorkerListUserInterfaceProtocol: class {
    func reloadTableView()
    func showActivityIndicator()
    func dismissActivityIndicator()
}

protocol WorkerListRouterProtocol {
    func navigateToWorkerDetailScene(withViewModel vm: WorkerViewModel)
}

class WorkerListBuilder {

    //MARK: - Configuration
    static func build() -> WorkerListViewController {
        let viewController = WorkerListViewController()
        let router = WorkerListRouter(view: viewController)
        let interactor = WorkerListInteractor()
        let presenter = WorkerListPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
