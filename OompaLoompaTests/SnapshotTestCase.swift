//
//  Created by Pierluigi Cifani on 02/03/2017.
//  Copyright © 2017 Blurred Software. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

class SnapshotTestCase: FBSnapshotTestCase {
    
    var currentWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
    
    var rootViewController: UIViewController? {
        get {
            return currentWindow.rootViewController
        }
        
        set(newRootViewController) {
            currentWindow.rootViewController = newRootViewController
            currentWindow.makeKeyAndVisible()
        }
    }
    
    override func setUp() {
        super.setUp()
        
        // Set the record mode depending of the environment variable from the Scheme
        // It allows to run in record mode with the Scheme "Record LiveScoreUIKit"
        if let _ = ProcessInfo.processInfo.environment["RECORD_MODE"] {
            recordMode = true
        } else {
            recordMode = false
        }
    }
    
    /// Add the view controller on the window and wait infinitly
    func debugViewController(_ viewController: UIViewController) {
        rootViewController = viewController
        _ = expectation(description: "No expectation")
        waitForExpectations(timeout: 6666, handler: nil)
    }
    
    func debugView(_ view: UIView) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        rootViewController = UIViewController()
        rootViewController?.view.backgroundColor = .white
        rootViewController?.view.addSubview(view)
        
        _ = expectation(description: "debug view")
        waitForExpectations(timeout: 6666, handler: nil)
    }
    
    /// Presents the VC using a fresh rootVC in the host's main window.
    /// - note: This method blocks the calling thread until the presentation is finished.
    func presentViewController(_ viewController: UIViewController) {
        let exp = expectation(description: "Presentation")
        rootViewController = UIViewController()
        rootViewController!.view.backgroundColor = .white // I just think it looks pretier this way
        rootViewController!.present(viewController, animated: true, completion: {
            exp.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Wrapper around FBSnapshotVerifyView that will first set it
    /// as rootViewController so we have a real view life cycle.
    /// Without this, viewWillAppear will not be called and it's necessary
    /// because that's where we call configureView()
    func verifyViewController(_ controller: UIViewController, afterDelay: TimeInterval = 0.05) {
        rootViewController = controller
        verifyView(controller.view, afterDelay: afterDelay)
    }
    
    func verifyView(_ view: UIView, afterDelay: TimeInterval = 0.05) {
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        let exp = expectation(description: "verify view")
        let deadlineTime = DispatchTime.now() + .milliseconds(Int(afterDelay * 1000))
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.FBSnapshotVerifyView(view)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1000) { _ in }
    }
}
