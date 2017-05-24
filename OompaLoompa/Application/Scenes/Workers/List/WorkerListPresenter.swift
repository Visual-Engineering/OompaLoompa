//
//  WorkerListPresenter.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class WorkerListPresenter {

    //MARK: - Stored properties
    fileprivate let router: WorkerListRouterProtocol
    fileprivate let interactor: WorkerListInteractorProtocol
    fileprivate unowned let view: WorkerListUserInterfaceProtocol

    var state: LoadingState<WorkerListViewModel> = .loading {
        didSet {
            switch state {
            case .loading:
                self.view.showActivityIndicator()
            case .loaded:
                self.view.dismissActivityIndicator()
                self.view.reloadTableView()
            case .error:
                self.view.dismissActivityIndicator()
            }
        }
    }

    var viewModel: WorkerListViewModel? {
        get {
            return state.viewModel
        }

        set {
            state.viewModel = newValue
        }
    }

    //MARK: - Initializer
    init(router: WorkerListRouterProtocol, interactor: WorkerListInteractorProtocol, view: WorkerListViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }

    //MARK: - Public API

}

extension WorkerListPresenter: WorkerListPresenterProtocol {

    func viewDidLoad() {
        view.showActivityIndicator()
        
        interactor.retrieveData().map(upon: .main) { (workerModelArray) -> WorkerListViewModel in
            return WorkerListViewModel(workers: workerModelArray.map { $0.toViewModel() })
        }.upon(.main) { (result) in
            switch result {
            case .failure(let error):
                self.state = .error(error)
            case .success(let workers):
                self.viewModel = workers
            }
        }
    }

    func numberOfRows() -> Int {
        return viewModel?.workers.count ?? 0
    }

    func element(at index: Int) -> WorkerViewModel? {
        guard let viewModel = viewModel, index < numberOfRows() else {
            return nil
        }
        return viewModel.workers[index]
    }

    func didSelectElement(at index: Int) {
        guard let element = element(at: index) else {
            return
        }

        router.navigateToWorkerDetailScene(withViewModel: element)
    }
}
