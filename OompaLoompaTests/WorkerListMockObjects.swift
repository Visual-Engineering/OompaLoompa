//
//  WorkerListMockObjects.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 29/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Deferred
@testable import OompaLoompa
@testable import OompaLoompaCore

//MARK: - Spies/Mocks...

class APIClientSpy: APIClientType {

    var called: Bool = false

    func retrieveWorkerList() -> Task<[WorkerModel]> {
        called = true
        return Task(success: [])
    }

    func reset() {
        called = false
    }
}

class WorkerListInteractorSpy: WorkerListInteractorProtocol {

    var called: Bool = false
    var completion: (() -> ())?

    func retrieveData() -> Task<[WorkerModel]> {
        called = true
        let task = Task(success: [WorkerModel.fake])
        return task
    }

    func reset() {
        called = false
    }
}

class WorkerListViewControllerSpy: WorkerListUserInterfaceProtocol {

    var reloadTableViewCalled: Bool = false
    var showActivityIndicatorCalled: Bool = false
    var dismissActivityIndicatorCalled: Bool = false

    func reloadTableView() {
        reloadTableViewCalled = true
    }

    func showActivityIndicator() {
        showActivityIndicatorCalled = true
    }

    func dismissActivityIndicator() {
        dismissActivityIndicatorCalled = true
    }

    func reset() {
        reloadTableViewCalled = false
        showActivityIndicatorCalled = false
        dismissActivityIndicatorCalled = false
    }
}

class WorkerListRouterSpy: WorkerListRouterProtocol {

    var called: Bool = false

    func navigateToWorkerDetailScene(withViewModel vm: WorkerViewModel) {
        called = true
    }

    func reset() {
        called = false
    }
}

class WorkerListPresenterFake: WorkerListPresenterProtocol {

    enum WorkerListUserInterfacePresenterState {
        case loading
        case loaded
    }

    var called: Bool = false
    var state: WorkerListUserInterfacePresenterState
    var view: WorkerListUserInterfaceProtocol

    init(view: WorkerListUserInterfaceProtocol, state: WorkerListUserInterfacePresenterState) {
        self.view = view
        self.state = state
    }

    func viewDidLoad() {
        called = true

        switch state {
        case .loading:
            view.showActivityIndicator()
        case .loaded:
            view.showActivityIndicator()
            view.dismissActivityIndicator()
            view.reloadTableView()
        }
    }

    func numberOfRows() -> Int {
        called = true
        return 5
    }

    func element(at index: Int) -> WorkerViewModel? {
        called = true
        return WorkerViewModel.fake
    }

    func didSelectElement(at index: Int) {

    }
}
