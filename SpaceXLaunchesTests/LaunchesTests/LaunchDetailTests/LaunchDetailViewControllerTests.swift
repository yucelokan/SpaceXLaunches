//
//  LaunchDetailViewControllerTests.swift
//  SpaceXLaunchDetail
//
//  Created by okan.yucel on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import SpaceXLaunches
import XCTest

final class LaunchDetailViewControllerTests: XCTestCase {
    // MARK: - Subject under test
    
    private var sut: LaunchDetailViewController!
    private var displayLogicSpy: LaunchDetailDisplayLogicSpy!
    private var workingLogicSpy: LaunchDetailWorkingLogicSpy!
    private var routingLogicSpy: LaunchDetailRouter!
    private var businessLogicSpy: LaunchDetailInteractor!
    private var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupLaunchDetailViewController()
        loadView()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    private func setupLaunchDetailViewController() {
        sut = UIApplication.getViewController()
        workingLogicSpy = LaunchDetailWorkingLogicSpy()
        routingLogicSpy = LaunchDetailRouter()
        businessLogicSpy = LaunchDetailInteractor(worker: workingLogicSpy)
        displayLogicSpy = LaunchDetailDisplayLogicSpy()
        let presenter = LaunchDetailPresenter()
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

    // MARK: - Tests
    
    func testFetchEmptyDetail() {
        XCTAssertFalse(displayLogicSpy.launchDetail)
        XCTAssertFalse(displayLogicSpy.loader)
        
        businessLogicSpy.fetchDetail(request: .init())
        
        XCTAssertFalse(displayLogicSpy.launchDetail)
        XCTAssertTrue(displayLogicSpy.loader)
        
        let promise = expectation(description: "Response handled")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 2)
        
        XCTAssertFalse(displayLogicSpy.launchDetail)
        XCTAssertFalse(displayLogicSpy.loader)
        
    }
    
    func testFetchLaunch() {
        XCTAssertFalse(displayLogicSpy.launchDetail)
        XCTAssertFalse(displayLogicSpy.loader)
        
        businessLogicSpy.fetchLaunch(request: .init())
        
        XCTAssertFalse(displayLogicSpy.launchDetail)
        XCTAssertTrue(displayLogicSpy.loader)
        
        let promise = expectation(description: "Response handled")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 2)
        
        XCTAssertFalse(displayLogicSpy.launchDetail)
        XCTAssertFalse(displayLogicSpy.loader)
        
    }
    
}
