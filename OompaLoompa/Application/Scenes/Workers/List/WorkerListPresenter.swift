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

    fileprivate var state: LoadingState<WorkerListViewModel> = .loading {
        didSet {
            switch state {
            case .loading:
                self.view.showActivityIndicator()
            case .loaded:
                self.view.dismissActivityIndicator()
                self.view.reloadTableView()
            case .updating:
                break
            case .error:
                self.view.dismissActivityIndicator()
            }
        }
    }

    var viewModel: WorkerListViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: WorkerListRouterProtocol, interactor: WorkerListInteractorProtocol, view: WorkerListUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension WorkerListPresenter: WorkerListPresenterProtocol {

    func viewDidLoad() {
        state = .loading
        retrieveData()
    }

    func numberOfRows() -> Int {
        guard let viewModel = viewModel else {
            return 0
        }

        return viewModel.numberOfRows()
    }

    func element(at index: Int) -> WorkerViewModel? {
        guard let viewModel = viewModel else {
            return nil
        }

        return viewModel.worker(at: index)
    }

    func didSelectElement(at index: Int) {
        guard let element = element(at: index) else {
            return
        }

        router.navigateToWorkerDetailScene(withViewModel: element)
    }

    func didFilter(withText text: String) {
        retrieveData(withFilter: text)
    }

    func didRefresh(withFilter text: String = "", completion: @escaping (Void) -> Void) {
        state = .updating
        retrieveData(withFilter: text, invalidateCache: true, completion: completion)
    }

    //MARK: - Private API
    private func retrieveData(withFilter text: String = "",
                              invalidateCache: Bool = false,
                              completion: @escaping (Void) -> Void = { }) {
        interactor.retrieveData(withFilter: text, invalidateCache: invalidateCache).map(upon: .main) { (workers) -> WorkerListViewModel in
            return WorkerListViewModel(workers: workers.map { $0.toViewModel() }, state: text.isEmpty ? .noFilter : .filtered)
            }.upon(.main) { (result) in
                switch result {
                case .failure(let error):
                    self.state = .error(error)
                case .success(let workers):
                    self.viewModel = workers
                }

                completion()
        }
    }
}
