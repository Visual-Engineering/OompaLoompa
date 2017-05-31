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

    func retrieveData(withFilter filter: String = "", invalidateCache: Bool = false) -> Task<[WorkerModel]> {
        let task = repository.retrieveWorkerList(invalidateCache: invalidateCache)

        if !filter.isEmpty {
            return task.map(upon: .main, transform: { (workers) -> [WorkerModel] in
                return workers.filter { $0.firstName.lowercased().contains(filter.lowercased()) ||
                                        $0.lastName.lowercased().contains(filter.lowercased()) ||
                                        $0.email.lowercased().contains(filter.lowercased()) ||
                                        $0.profession.lowercased().contains(filter.lowercased())}
            })
        } else {
            return task
        }
    }
}
