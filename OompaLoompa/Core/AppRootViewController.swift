//
//  AppRootViewController.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

protocol AppTransitionDelegate {
    
    func performTransition(animated: Bool,
                           fromViewController: UIViewController?,
                           toViewController: UIViewController,
                           containerView: UIView,
                           completion: @escaping (Bool) -> ())
}

class AppRootViewController: UIViewController {

    //MARK: - Stored properties
    private(set) var currentViewController: UIViewController?
    var transitionDelegate: AppTransitionDelegate?
    
    //MARK: - Overrided properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let currentViewController = currentViewController else {
            return UIStatusBarStyle.default
        }
        return currentViewController.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        guard let currentViewController = currentViewController else {
            return false
        }
        return currentViewController.prefersStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        guard let currentViewController = currentViewController else {
            return UIStatusBarAnimation.none
        }
        return currentViewController.preferredStatusBarUpdateAnimation
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return currentViewController
    }
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return currentViewController
    }

    //MARK: - Private API
    func transitionToRootViewController(_ toViewController: UIViewController, animated: Bool = true) {
        let fromViewController: UIViewController? = currentViewController
        
        add(viewController: toViewController)
        
        let receiver: AppTransitionDelegate = transitionDelegate ?? self
        receiver.performTransition(animated: animated, fromViewController: fromViewController, toViewController: toViewController, containerView: view) { [weak self] _ in
            guard let fromViewController = fromViewController else { return }
            self?.remove(viewController: fromViewController)
        }
        
        currentViewController = toViewController
    }
    
    private func add(viewController: UIViewController) {
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
    }
}

extension AppRootViewController: AppTransitionDelegate {
    
    func performTransition(animated: Bool,
                           fromViewController: UIViewController?,
                           toViewController: UIViewController,
                           containerView: UIView,
                           completion: @escaping (Bool) -> ()) {
        
        toViewController.view.alpha = 0.0
        
        containerView.addSubviewWithAutolayout(toViewController.view)
        toViewController.view.fillSuperview()
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            if let fromViewController = fromViewController {
                fromViewController.view.transform = fromViewController.view.transform.scaledBy(x: 0.7, y: 0.7)
                fromViewController.view.alpha = 0.0
            }
            
            toViewController.view.alpha = 1.0
            
        }, completion: completion)
    }
}
