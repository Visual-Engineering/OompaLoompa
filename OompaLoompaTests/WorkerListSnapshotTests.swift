//
//  WorkerListSnapshotTests.swift
//  OompaLoompa
//
//  Created by Jordi Aguila on 26/05/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import OompaLoompa

class WorkerListSnapshotTests: SnapshotTestCase {

    override func setUp() {
        super.setUp()
        isDeviceAgnostic = true
//        recordMode = true
    }
  
    func testSnapshotWorkerListCell() {
        let cell = WorkerListCell()
        cell.frame = CGRect(origin: .zero, size: CGSize(width:currentWindow.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        cell.configure(forViewModel: WorkerViewModel.fake)
        cell.frame = CGRect(origin: .zero, size: cell.fitSize(widthConstraint:currentWindow.bounds.width))
        verifyView(cell)
    }

    func testSnapshotWorkerListViewControllerLoadingState() {
        let viewController = WorkerListViewController()
        let presenter = WorkerListPresenterFake(view: viewController, state: .loading)
        viewController.presenter = presenter
        verifyViewControllerInWidndow(viewController, afterDelay: 1.0)
    }

    func testSnapshotWorkerListViewControllerLoadedState() {
        let viewController = WorkerListViewController()
        let presenter = WorkerListPresenterFake(view: viewController, state: .loaded)
        viewController.presenter = presenter
        verifyViewControllerInWidndow(viewController, afterDelay: 1.0)
    }

    func testDebugWorkerListViewController() {
        let viewController = WorkerListViewController()
        let presenter = WorkerListPresenterFake(view: viewController, state: .loaded)
        viewController.presenter = presenter
        debugViewController(viewController)
    }
}
