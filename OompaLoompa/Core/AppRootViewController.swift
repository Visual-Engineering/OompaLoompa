//
//  AppRootViewController.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

class AppRootViewController: UIViewController {

    //MARK: - Stored properties
    var rootViewController: UIViewController?

    //MARK: - Private API
    func transitionToRootViewController(_ toRootViewController: UIViewController, animated: Bool? = true) {
        let fromViewController: UIViewController? = rootViewController

        addChildViewController(toRootViewController)
        toRootViewController.didMove(toParentViewController: self)
        toRootViewController.view.alpha = 0.0

        view.addSubviewWithAutolayout(toRootViewController.view)
        toRootViewController.view.fillSuperview()

        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            if let fromViewController = fromViewController {
                fromViewController.view.transform = fromViewController.view.transform.scaledBy(x: 0.7, y: 0.7)
                fromViewController.view.alpha = 0.0
            }

            toRootViewController.view.alpha = 1.0

        }, completion: { (_) -> Void in
            fromViewController?.willMove(toParentViewController: nil)
            fromViewController?.removeFromParentViewController()
            fromViewController?.view.removeFromSuperview()
        })

        rootViewController = toRootViewController
    }
}
