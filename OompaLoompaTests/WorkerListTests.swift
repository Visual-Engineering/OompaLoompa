//
//  WorkerListInteractorTests.swift
//  OompaLoompa
//
//  Created by Jordi Aguila on 25/05/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
import Deferred
@testable import OompaLoompa
@testable import OompaLoompaCore

class WorkerListTests: XCTestCase {
    
    let interactorSpy = WorkerListInteractorSpy()
    let viewSpy = WorkerListViewControllerSpy()
    let routerSpy = WorkerListRouterSpy()
    let apiClient = APIClientSpy()

    override func setUp() {
        super.setUp()
        interactorSpy.reset()
        viewSpy.reset()
        routerSpy.reset()
        apiClient.reset()
    }
    
    //MARK: Interactor
    
    func testInteractorRetrieveData() {
        
        // given
        let interactor = WorkerListInteractor(apiProvider: apiClient)
        
        // when
        _ = interactor.retrieveData()
        
        // then
        XCTAssert(apiClient.called, "APIClient function 'retrieveWorkerList' should be called")
    }
    
    //MARK: Presenter
    func testPresenterRequestData() {
        
        // given
        let presenter = WorkerListPresenter(router: routerSpy, interactor: interactorSpy, view: viewSpy)
        
        // when
        presenter.viewDidLoad()
        
        // then 
        XCTAssert(interactorSpy.called, "Interactor should be requested for data")
    }
    
    func testPresenterSelectElementToNavigate() {
        
        // given
        let presenter = WorkerListPresenter(router: routerSpy, interactor: interactorSpy, view: viewSpy)
        presenter.viewDidLoad()
        waitDeferredToFill()
        
        // when
        presenter.didSelectElement(at: 0)
        
         // then
        XCTAssert(self.routerSpy.called, "Router should be called to navigate to a detail view")
    }
}
