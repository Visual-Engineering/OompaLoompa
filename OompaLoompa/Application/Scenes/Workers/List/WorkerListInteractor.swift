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

    //MARK: - Singleton
    static let interactor = WorkerListInteractor()
    private init() { }

    //MARK: - Stored properties
    var apiProvider = APIClient.provider
}

extension WorkerListInteractor: WorkerListInteractorProtocol {

    func retrieveData() -> Task<[WorkerModel]> {
        return apiProvider.retrieveWorkerList()
    }
}
