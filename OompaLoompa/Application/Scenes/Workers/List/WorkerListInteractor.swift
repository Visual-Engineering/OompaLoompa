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
    
    var apiProvider: APIClientType

    init(apiProvider: APIClientType = APIClient.provider) {
        self.apiProvider = apiProvider
    }
}

extension WorkerListInteractor: WorkerListInteractorProtocol {

    func retrieveData() -> Task<[WorkerModel]> {
        return apiProvider.retrieveWorkerList()
    }

//    func filterData(byName name: String) -> Task<[WorkerModel]> {
//        return []
//    }
}
