//
//  SplashRouter.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import UIKit
import Extensions

protocol SplashRoutingLogic: AnyObject {
    func routeLaunches()
}

protocol SplashDataPassing: AnyObject {
    var dataStore: SplashDataStore? { get }
}

final class SplashRouter: SplashRoutingLogic, SplashDataPassing {
    
    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?
    
    func routeLaunches() {
        let launchesViewController: LaunchesViewController = UIApplication.getViewController()
        launchesViewController.navigationItem.hidesBackButton = true
        viewController?.navigationController?.pushViewController(launchesViewController, animated: true)
    }
    
}
