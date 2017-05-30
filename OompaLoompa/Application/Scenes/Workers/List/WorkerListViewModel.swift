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
}

enum FilteredState {
    case noFilter
    case filtered(workers: [WorkerViewModel])
}

extension WorkerListViewModel {

    init(workers: [WorkerViewModel]) {
        self.state = .noFilter
        self.workers = workers
    }

    func numberOfRows() -> Int {
        switch state {
        case .filtered(let filteredWorkers):
            return filteredWorkers.count
        case .noFilter:
            return workers.count
        }
    }

    func worker(at index: Int) -> WorkerViewModel? {
        guard index < numberOfRows() else {
            return nil
        }
        switch state {
        case .filtered(let filteredWorkers):
            return filteredWorkers[index]
        case .noFilter:
            return self.workers[index]
        }
    }

    mutating func filterWorkers(byText text: String) {
        let filteredWorkers = workers.filter { $0.name.lowercased().contains(text.lowercased()) ||
                                           $0.email.lowercased().contains(text.lowercased()) ||
                                           $0.profession.lowercased().contains(text.lowercased())}

        state = .filtered(workers: filteredWorkers)
    }

    mutating func resetFilter() {
        state = .noFilter
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
