//
//  WorkerListViewModel.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import OompaLoompaCore

struct WorkerListViewModel {

    //MARK: - Stored properties
    fileprivate let workers: [WorkerViewModel]
    var state: FilteredState

    //MARK: - Initializer
    init(workers: [WorkerViewModel], state: FilteredState = .noFilter) {
        self.workers = workers
        self.state = state
    }
}

enum FilteredState {
    case noFilter
    case filtered
}

extension WorkerListViewModel {

    func numberOfRows() -> Int {
        return workers.count
    }

    func worker(at index: Int) -> WorkerViewModel? {
        guard index < numberOfRows() else {
            return nil
        }

        return self.workers[index]
    }
}

struct WorkerViewModel {

    //MARK: - Stored properties
    let id: Int
    let name: String
    let email: String
    let profession: String
    let genderImageName: String
    let thumbnailURLPath: String
    let imageURLPath: String
    var isHidden: Bool
}

extension WorkerModel {

    func toViewModel() -> WorkerViewModel {
        return WorkerViewModel(id: id,
                               name: firstName.appending(" ").appending(lastName),
                               email: email,
                               profession: profession,
                               genderImageName: gender.imageName,
                               thumbnailURLPath: thumbnail,
                               imageURLPath: imageURLPath,
                               isHidden: false)
    }

}
