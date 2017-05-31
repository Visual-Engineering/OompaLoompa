//
//  WorkersRepository.swift
//  Pods
//
//  Created by Alejandro Garcia on 30/5/17.
//
//

import Foundation
import Deferred

public protocol WorkersRepositoryProtocol {
    func retrieveWorkerList(invalidateCache: Bool) -> Task<[WorkerModel]>
}

public class WorkersRepository {

    //MARK: - Stored properties
    fileprivate let apiProvider: APIProviderProtocol
    fileprivate let databaseProvider: DatabaseProviderProtocol

    //MARK: - Initializer
    public init(apiProvider: APIProviderProtocol = APIProvider.provider,
                databaseProvider: DatabaseProviderProtocol = RealmDataBaseProvider.provider) {
        self.apiProvider = apiProvider
        self.databaseProvider = databaseProvider
    }
}

extension WorkersRepository: WorkersRepositoryProtocol {

    public func retrieveWorkerList(invalidateCache: Bool) -> Task<[WorkerModel]> {
        var workers = [WorkerModel]()

        if invalidateCache {
            databaseProvider.reset()
        } else {
            workers = databaseProvider.read()
        }

        if workers.isEmpty {
            return apiProvider.retrieveWorkerList().map(upon: .main, transform: { [weak self] (workers) -> [WorkerModel] in
                self?.databaseProvider.write(elements: workers)
                return workers
            })
        } else {
            return Task(success: workers)
        }
    }
}
