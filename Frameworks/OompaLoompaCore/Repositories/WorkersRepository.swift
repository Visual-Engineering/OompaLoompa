//
//  WorkersRepository.swift
//  Pods
//
//  Created by Alejandro Garcia on 30/5/17.
//
//

import Foundation
import Deferred

class WorkersRepository {

    //MARK: - Stored properties
    fileprivate let apiProvider: APIProvider
    //fileprivat let sessionProvider =...

    //MARK: - Initializer
    init(apiProvider: APIProvider = APIProvider.provider) {
        self.apiProvider = apiProvider
    }

    //MARK: - Public API
    func retrieveWorkerList(invalidateCache: Bool = false) -> Task<[WorkerModel]> {
        if invalidateCache {
            return apiProvider.retrieveWorkerList()
        } else {
            return apiProvider.retrieveWorkerList()
        }
    }
}
