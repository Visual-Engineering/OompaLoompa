//
//  DataBaseProvider.swift
//  Pods
//
//  Created by Alejandro Garcia on 30/5/17.
//
//

import Foundation
import RealmSwift

public protocol DatabaseProviderProtocol {
    func write<M: DatabaseConvertible>(elements: [M])
    func read<M: DatabaseConvertible>() -> [M]
    func reset()
}

class RealmDataBaseProvider {

    //MARK: - Singleton
    static let provider = RealmDataBaseProvider()
    private init() { }

    //MARK: - Stored properties
    fileprivate lazy var realm = try! Realm()
}

extension RealmDataBaseProvider: DatabaseProviderProtocol {

    func write<M: DatabaseConvertible>(elements: [M]) {
        do {
            let dbElements = elements.map { $0.toDBModel() }

            try realm.write {
                realm.add(dbElements)
            }
        } catch {
            //TODO: - Handle error
        }
    }

    func read<M: DatabaseConvertible>() -> [M] {
        let dbElements = realm.objects(M.DB.self)
        let elements = dbElements.map { M.init(fromDBModel: $0) }
        return Array(elements)
    }

    func reset() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            //TODO: - Handle error
        }
    }
}
