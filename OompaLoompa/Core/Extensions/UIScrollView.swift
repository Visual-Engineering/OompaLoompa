
//  UIView+refresh.swift
//  Pods
//
//  Created by Alba Luján on 24/5/17.
//
//

import UIKit

extension UIScrollView {

    public typealias VoidClosure = ()->()
    public typealias ActionClosure = (@escaping VoidClosure) -> ()

    fileprivate struct AssociatedObjects {
        static var ActionBlockWrapper = "ActionBlockWrapper"
    }

    var action: ActionClosure {
        get {
            return (objc_getAssociatedObject(self, &AssociatedObjects.ActionBlockWrapper) as! ActionClosure)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjects.ActionBlockWrapper, newValue as ActionClosure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    public func addRefresh(action: @escaping ActionClosure) {

        self.action = action
        self.alwaysBounceVertical = true
        self.bounces = true

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.reload(_:)), for: UIControlEvents.valueChanged)

        addSubview(refreshControl)
        sendSubview(toBack: refreshControl)
    }

    public func reload(_ sender: UIRefreshControl) {
        self.action {
            sender.endRefreshing()
        }
    }
}
