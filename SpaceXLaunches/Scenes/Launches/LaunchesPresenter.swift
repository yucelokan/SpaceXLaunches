//
//  LaunchesPresenter.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import Foundation
import Extensions

protocol LaunchesPresentationLogic: AnyObject {
    func presentSnapshot(response: Launches.SubscribeLaunches.Response)
    func presentLoader(response: Launches.Loader.Response)
    func presentDetail(response: Launches.Select.Response)
    func presentError(message: String)
}

final class LaunchesPresenter: LaunchesPresentationLogic {
    
    weak var viewController: LaunchesDisplayLogic?
    
    func presentSnapshot(response: Launches.SubscribeLaunches.Response) {
        DispatchQueue.global(qos: .userInitiated).async {
            let uniques = response.launches.unique()
            var snapshot = Launches.DiffableSnapShot()
            snapshot.appendSections([.main])
            snapshot.appendItems(uniques)
            DispatchQueue.main.async {
                self.viewController?.displaySnapshot(viewModel: .init(snapshot: snapshot))
            }
        }
    }
    
    func presentLoader(response: Launches.Loader.Response) {
        viewController?.displayLoader(viewModel: .init(loaders: response.loaders))
    }
    
    func presentDetail(response: Launches.Select.Response) {
        viewController?.displayDetail(viewModel: .init(launch: response.launch))
    }
    
    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
}
