//
//  WorkerModelDB.swift
//  Pods
//
//  Created by Alejandro Garcia on 31/5/17.
//
//

import Foundation
import RealmSwift
import Realm

public protocol DatabaseConvertible {
    associatedtype DB: Object

    init(fromDBModel model: DB)
    func toDBModel() -> DB
}

public class WorkerModelDB: Object {

    //MARK: - Stored properties
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var profession: String = ""
    dynamic var gender: String = ""
    dynamic var thumbnail: String = ""
    dynamic var imageURLPath: String = ""
}

extension WorkerModel: DatabaseConvertible {

    public init(fromDBModel model: WorkerModelDB) {
        self.id = model.id
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.email = model.email
        self.profession = model.profession
        self.gender = Converters.genderFromString(model.gender)
        self.thumbnail = model.thumbnail
        self.imageURLPath = model.imageURLPath
    }

    public func toDBModel() -> WorkerModelDB {
        let workerModelDB = WorkerModelDB()
        workerModelDB.id = id
        workerModelDB.firstName = firstName
        workerModelDB.lastName = lastName
        workerModelDB.email = email
        workerModelDB.profession = profession
        workerModelDB.gender = gender.rawValue
        workerModelDB.thumbnail = thumbnail
        workerModelDB.imageURLPath = imageURLPath

        return workerModelDB
    }
}
