//
//  WorkerListInteractor.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import OompaLoompaCore

class WorkerListInteractor {

    //MARK: - Stored properties
    let repository: WorkersRepositoryProtocol

    //MARK: - Initializer
    init(repository: WorkersRepositoryProtocol = WorkersRepository()) {
        self.repository = repository
    }
}

extension WorkerListInteractor: WorkerListInteractorProtocol {

    func retrieveData() -> Task<[WorkerModel]> {
        return repository.retrieveWorkerList(invalidateCache: false)
    }

//    func filterData(byName name: String) -> Task<[WorkerModel]> {
//        return []
//    }
}
