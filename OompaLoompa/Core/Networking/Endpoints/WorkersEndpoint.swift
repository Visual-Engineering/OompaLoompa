//
//  WorkersEndpoint.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import BSWFoundation

enum WorkersEndpoint {
    case list
}

extension WorkersEndpoint: BSWFoundation.Endpoint {

    var path: String {
        var path: String

        switch self {
        case .list:
            path = "/aaafc040/download?count=10&key=aa8685c0"
        }

        print("**** API Request: \(path)")

        return path
    }
}
