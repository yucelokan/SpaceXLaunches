//
//  LaunchesDisplayLogicSpy.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import SpaceXLaunches
import XCTest

final class LaunchesDisplayLogicSpy: LaunchesDisplayLogic {
    
    var snapshot = false
    var loaderHeader = false
    var loaderFooter = false
    var routeDetail = false
    var error = false
    
    func displaySnapshot(viewModel: Launches.SubscribeLaunches.ViewModel) {
        error = false
        snapshot = viewModel.snapshot.numberOfItems > 0
    }
    
    func displayLoader(viewModel: Launches.Loader.ViewModel) {
        viewModel.loaders.forEach { loader in
            switch loader {
            case .footer(let loading):
                loaderFooter = loading
            case .pullToRefresh(let loading):
                loaderHeader = loading
            }
        }
    }
    
    func displayDetail(viewModel: Launches.Select.ViewModel) {
        routeDetail = true
    }
    
    func displayError(message: String) {
        error = true
    }
    
}
