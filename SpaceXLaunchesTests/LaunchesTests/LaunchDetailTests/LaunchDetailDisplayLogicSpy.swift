//
//  LaunchDetailDisplayLogicSpy.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import SpaceXLaunches
import XCTest

final class LaunchDetailDisplayLogicSpy: LaunchDetailDisplayLogic {
    
    var launchDetail = false
    var loader = false
    var error = false
    
    func displayLaunchDetail(viewModel: LaunchDetail.FetchDetail.ViewModel) {
        error = false
        launchDetail = !viewModel.launch.launchMissionName.isEmpty
    }
    
    func displayLoader(viewModel: LaunchDetail.Loader.ViewModel) {
        loader = viewModel.loading
    }
    
    func displayError(message: String) {
        error = true
    }

}
