//
//  WorkerListViewModel.swift
//  OompaLoompa
//
//  Created by Alejandro Garcia on 18/5/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

struct WorkerListViewModel {

    //MARK: - Stored properties
    let workers: [WorkerViewModel]

}

struct WorkerViewModel {

    //MARK: - Stored properties
    let id: Int
    let name: String
    let email: String
    let profession: String
    let genderImageName: String
    let thumbnailURLPath: String
    let imageURLPath: String
}

extension WorkerModel {

    func toViewModel() -> WorkerViewModel {
        return WorkerViewModel(id: id,
                               name: firstName.appending(" ").appending(lastName),
                               email: email,
                               profession: profession,
                               genderImageName: gender.imageName,
                               thumbnailURLPath: thumbnail,
                               imageURLPath: imageURLPath)
    }

}
