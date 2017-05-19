//
//  WorkerModel.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Decodable

enum Gender: String {
    case male
    case female
    case shemale
}

extension Gender {

    var imageName: String {
        return rawValue
    }
}

struct WorkerModel {

    //MARK: - Stored properties
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let profession: String
    let gender: Gender
    let thumbnail: String
    let imageURLPath: String
}

extension WorkerModel: Decodable {

    static func decode(_ json: Any) throws -> WorkerModel {
        return try WorkerModel(id: json => "id",
                               firstName: json => "first_name",
                               lastName: json => "last_name",
                               email: json => "email",
                               profession: json => "profession",
                               gender: Converters.genderFromString(json => "gender"),
                               thumbnail: json => "thumbnail",
                               imageURLPath: json => "image")
    }
}

struct Converters {

    static let genderFromString: (String) -> Gender = { gender in
        switch gender {
        case "M":
            return .male
        case "F":
            return .female
        default:
            return .shemale
        }
    }
}
