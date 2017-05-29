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
  
    func testSnapshotWorkerListCell() {
        let cell = WorkerListCell()
        cell.frame = CGRect(origin: .zero, size: CGSize(width:currentWindow.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        cell.configure(forViewModel: WorkerViewModel.fake)
        cell.frame = CGRect(origin: .zero, size: cell.fitSize(widthConstraint:currentWindow.bounds.width))
        verifyView(cell)
    }

    func testSnapshotWorkerListViewControllerLoadingState() {
//        recordMode = true
        let viewController = WorkerListViewController()
        let presenter = WorkerListPresenterSpy(view: viewController, stateToTest: .loading)
        viewController.presenter = presenter
        verifyViewControllerInWidndow(viewController, afterDelay: 1.0, tolerance: 0.0)
    }
}
