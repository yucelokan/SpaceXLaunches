//
//  LaunchesViewControllerTests.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import SpaceXLaunches
import XCTest

final class LaunchesViewControllerTests: XCTestCase {
    // MARK: - Subject under test
    
    private var sut: LaunchesViewController!
    private var displayLogicSpy: LaunchesDisplayLogicSpy!
    private var workingLogicSpy: LaunchesWorkingLogicSpy!
    private var routingLogicSpy: LaunchesRouter!
    private var businessLogicSpy: LaunchesInteractor!
    private var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupLaunchesViewController()
        loadView()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    private func setupLaunchesViewController() {
        sut = UIApplication.getViewController()
        workingLogicSpy = LaunchesWorkingLogicSpy()
        routingLogicSpy = LaunchesRouter()
        businessLogicSpy = LaunchesInteractor(worker: workingLogicSpy)
        displayLogicSpy = LaunchesDisplayLogicSpy()
        let presenter = LaunchesPresenter()
        presenter.viewController = displayLogicSpy
        businessLogicSpy.worker = workingLogicSpy
        businessLogicSpy.presenter = presenter
        sut.interactor = businessLogicSpy
        sut.router = routingLogicSpy
    }
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func testFetch() {
        XCTAssertFalse(displayLogicSpy.snapshot)
        XCTAssertTrue(displayLogicSpy.loaderHeader)
        XCTAssertFalse(displayLogicSpy.loaderFooter)
        
        businessLogicSpy.subscribeLaunches(request: .init())
        businessLogicSpy.fetchLaunches(request: .init())
        
        let promise = expectation(description: "Response handled")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 2)
        
        XCTAssertTrue(displayLogicSpy.snapshot)
        XCTAssertFalse(displayLogicSpy.loaderHeader)
        XCTAssertFalse(displayLogicSpy.loaderFooter)
        
    }
    
    func testFetchMoreDuplication() {
        XCTAssertFalse(displayLogicSpy.snapshot)
        XCTAssertTrue(displayLogicSpy.loaderHeader)
        XCTAssertFalse(displayLogicSpy.loaderFooter)
        
        businessLogicSpy.fetchMoreLaunches(request: .init())
        
        let promise = expectation(description: "Response handled")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 2)
        
        XCTAssertTrue(displayLogicSpy.snapshot)
        XCTAssertFalse(displayLogicSpy.loaderHeader)
        XCTAssertFalse(displayLogicSpy.loaderFooter)
    }

    // MARK: - Tests
    
}
