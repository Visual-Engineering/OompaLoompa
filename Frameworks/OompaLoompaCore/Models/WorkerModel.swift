//
//  WorkerModel.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Decodable

public enum Gender: String {
    case male
    case female
    case shemale
}

extension Gender {

    public var imageName: String {
        return rawValue
    }
}

public struct WorkerModel {

    //MARK: - Stored properties
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let email: String
    public let profession: String
    public let gender: Gender
    public let thumbnail: String
    public let imageURLPath: String
}

extension WorkerModel: Decodable {

    public static func decode(_ json: Any) throws -> WorkerModel {
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
