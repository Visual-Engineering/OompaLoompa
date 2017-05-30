//
//  Scene+Common.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

enum LoadingState<VM> {
    case loading
    case loaded(viewModel: VM)
    case error(Error)
}

extension LoadingState {
    var viewModel: VM? {
        get {
            switch self {
            case .loaded(let vm):
                return vm
            default:
                return nil
            }
        }
    }
}

enum AppError: Error {
    case unknown
}
