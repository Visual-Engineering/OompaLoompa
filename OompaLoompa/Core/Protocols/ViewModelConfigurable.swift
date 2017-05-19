//
//  ViewModelConfigurable.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    associatedtype VM
    func configure(forViewModel vm: VM)
}
