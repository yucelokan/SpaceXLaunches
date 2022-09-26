//
//  LaunchDetailPresenter.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation

protocol LaunchDetailPresentationLogic: AnyObject {
    func presentLaunchDetail(response: LaunchDetail.FetchDetail.Response)
    func presentLoader(response: LaunchDetail.Loader.Response)
    func presentError(message: String)
}

final class LaunchDetailPresenter: LaunchDetailPresentationLogic {
    
    weak var viewController: LaunchDetailDisplayLogic?
    
    func presentLaunchDetail(response: LaunchDetail.FetchDetail.Response) {
        viewController?.displayLaunchDetail(viewModel: .init(launch: response.launch))
    }
    
    func presentLoader(response: LaunchDetail.Loader.Response) {
        viewController?.displayLoader(viewModel: .init(loading: response.loading))
    }
    
    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
}
