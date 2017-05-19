//
//  UIView.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

extension UIView {

    public func fillSuperview(withEdges edges: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let parent = self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false

        self.topAnchor.constraint(equalTo: parent.topAnchor, constant: edges.top).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: edges.left).isActive = true
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -edges.right).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -edges.bottom).isActive = true
    }

    func addSubviewWithAutolayout(_ view: UIView) {
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func insertSubviewWithAutolayout(_ view: UIView, at index: Int) {
        insertSubview(view, at: index)

        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
