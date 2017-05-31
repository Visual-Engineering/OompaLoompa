//
//  Scene+Common.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

protocol LoadableProtocol {
    associatedtype VM

    var viewModel: VM? { get set }
    var state: LoadingState<VM> { get set }
}

enum LoadingState<VM> {
    case loading
    case loaded(viewModel: VM)
    case updating
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
