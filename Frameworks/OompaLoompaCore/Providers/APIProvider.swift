//
//  APIClient.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import BSWFoundation
import Deferred
import Decodable

enum APIError: Error {
    case unknownError
}

enum Environment {
    case prod
}

extension Environment: BSWFoundation.Environment {

    var basePath: String {
        switch self {
        case .prod:
            return "https://www.mockaroo.com"
        }
    }
}

public protocol APIProviderProtocol {
    func retrieveWorkerList() -> Task<[WorkerModel]>
}

public class APIProvider {

    //MARK: - Singleton
    public static let provider = APIProvider()
    private init() { }

    fileprivate let drosky = Drosky(environment: Environment.prod)

    static fileprivate let queue = queueForSubmodule("APIProvider")
}

extension APIProvider: APIProviderProtocol {
    
    public func retrieveWorkerList() -> Task<[WorkerModel]> {
        let endpoint = WorkersEndpoint.list
        return drosky.performRequest(forEndpoint: endpoint) ≈> processResponse
    }
}

fileprivate let jsonSerializationOptions = JSONSerialization.ReadingOptions.allowFragments

extension APIProvider {

    fileprivate func processResponse<T: Decodable>(_ response: DroskyResponse) -> Task<T> {
        let deferred = Deferred<TaskResult<T>>()

        APIProvider.queue.addOperation {
            switch response.statusCode {
            case 200,
                 201,
                 204:
                deferred.fill(with: JSONParser.parseData(response.data))
            default:
                deferred.fill(with: .failure(APIError.unknownError))
            }
        }

        return Task(future: Future(deferred))
    }

    fileprivate func processResponse<T: Decodable>(_ response: DroskyResponse) -> Task<[T]> {
        let deferred = Deferred<TaskResult<[T]>>()

        APIProvider.queue.addOperation {
            switch response.statusCode {
            case 200,
                 201:
                deferred.fill(with: JSONParser.parseData(response.data))
            default:
                deferred.fill(with: .failure(APIError.unknownError))
            }
        }

        return Task(future: Future(deferred))
    }

    fileprivate func processResponse(_ response: DroskyResponse) -> Task<()> {
        let deferred = Deferred<TaskResult<()>>()

        APIProvider.queue.addOperation {
            switch response.statusCode {
            case 200,
                 201,
                 204:
                deferred.fill(with: .success(()))
            default:
                deferred.fill(with: .failure(APIError.unknownError))
            }
        }

        return Task(future: Future(deferred))
    }
}
