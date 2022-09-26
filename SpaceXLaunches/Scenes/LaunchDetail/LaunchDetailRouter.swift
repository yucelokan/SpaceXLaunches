//
//  LaunchDetailRouter.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation

protocol LaunchDetailRoutingLogic: AnyObject {
    
}

protocol LaunchDetailDataPassing: AnyObject {
    var dataStore: LaunchDetailDataStore? { get }
}

final class LaunchDetailRouter: LaunchDetailRoutingLogic, LaunchDetailDataPassing {
    
    weak var viewController: LaunchDetailViewController?
    var dataStore: LaunchDetailDataStore?
    
}
