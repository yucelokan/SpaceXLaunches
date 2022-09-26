//
//  LaunchesRouter.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import UIKit
import Extensions

protocol LaunchesRoutingLogic: AnyObject {
    func routeToLaunchDetail(viewModel: Launches.Select.ViewModel)
}

protocol LaunchesDataPassing: AnyObject {
    var dataStore: LaunchesDataStore? { get }
}

final class LaunchesRouter: LaunchesRoutingLogic, LaunchesDataPassing {
    
    weak var viewController: LaunchesViewController?
    var dataStore: LaunchesDataStore?
    
    func routeToLaunchDetail(viewModel: Launches.Select.ViewModel) {
        let detailViewController: LaunchDetailViewController = UIApplication.getViewController()
        detailViewController.router?.dataStore?.launch = viewModel.launch
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
