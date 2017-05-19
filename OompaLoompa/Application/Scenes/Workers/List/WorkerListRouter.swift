//
//  WorkerListRouter.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class WorkerListRouter {

    //MARK: - Stored properties
    unowned let view: WorkerListViewController

    //MARK: Initializer
    init(view: WorkerListViewController) {
        self.view = view
    }
}

extension WorkerListRouter: WorkerListRouterProtocol {

    func navigateToWorkerDetailScene(withViewModel vm: WorkerViewModel) {
        guard let navigation = view.navigationController else {
            return
        }

        let detailViewController = WorkerDetailBuilder.build(withViewModel: vm)
        navigation.pushViewController(detailViewController, animated: true)
    }
}
