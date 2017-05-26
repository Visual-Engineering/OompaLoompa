//
//  TestsCommon.swift
//  OompaLoompa
//
//  Created by Jordi Aguila on 26/05/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
import XCTest

//MARK: - Helpers
func afterDelay(upon queue: DispatchQueue = .main, execute body: @escaping() -> ()) {
    queue.asyncAfter(deadline: .now() + 0.15, execute: body)
}

extension XCTestCase {
    func waitDeferredToFill() {
        let exp = expectation(description: "Waiting for the defered values to resolve")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
