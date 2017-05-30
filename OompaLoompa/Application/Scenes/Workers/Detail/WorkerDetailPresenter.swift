//
//  WorkerDetailPresenter.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 19/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class WorkerDetailPresenter {

    //MARK: - Stored properties
    fileprivate let router: WorkerDetailRouter
    fileprivate let interactor: WorkerDetailInteractorProtocol
    fileprivate unowned let view: WorkerDetailViewController

    var state: LoadingState<WorkerViewModel> = .loading

    var viewModel: WorkerViewModel? {
        get {
            return state.viewModel
        }

        set {
            guard let value = newValue else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: value)
        }
    }

    //MARK: - Initializer
    init(router: WorkerDetailRouter, interactor: WorkerDetailInteractorProtocol, view: WorkerDetailViewController, viewModel: WorkerViewModel) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.viewModel = viewModel
    }
}

extension WorkerDetailPresenter: WorkerDetailPresenterProtocol {

    func viewDidLoad() {
        guard let viewModel = viewModel else {
            return
        }
        view.configure(forViewModel: viewModel)
    }
}
