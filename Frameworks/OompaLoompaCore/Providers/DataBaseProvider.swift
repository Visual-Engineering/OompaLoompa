//
//  DataBaseProvider.swift
//  Pods
//
//  Created by Alejandro Garcia on 30/5/17.
//
//

import Foundation
import RealmSwift

class DataBaseProvider {

    //MARK: - Singleton
    static let provider = DataBaseProvider()
    private init() { }

    //MARK: - Stored properties
    fileprivate let realm = try! Realm()
}
