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
}
