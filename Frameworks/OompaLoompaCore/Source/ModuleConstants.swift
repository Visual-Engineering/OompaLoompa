//
//  ModuleConstants.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation

let ModuleName = "com.oompaLoompaios"

func submoduleName(_ submodule : String) -> String {
    return ModuleName + "." + submodule
}

func queueForSubmodule(_ submodule : String, qualityOfService: QualityOfService = .default) -> OperationQueue {
    let queue = OperationQueue()
    queue.name = submoduleName(submodule)
    queue.qualityOfService = qualityOfService
    return queue
}
