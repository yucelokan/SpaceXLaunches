//
//  LaunchDetailInteractor.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation
import API

protocol LaunchDetailBusinessLogic: AnyObject {
    func fetchDetail(request: LaunchDetail.FetchDetail.Request)
    func fetchLaunch(request: LaunchDetail.FetchLaunch.Request)
}

protocol LaunchDetailDataStore: AnyObject {
    var launch: Launches.LaunchQueryItem { get set }
}

final class LaunchDetailInteractor: LaunchDetailBusinessLogic, LaunchDetailDataStore {
    
    var presenter: LaunchDetailPresentationLogic?
    var worker: LaunchDetailWorkingLogic?
    
    init(worker: LaunchDetailWorkingLogic) {
        self.worker = worker
    }
    
    var launch: Launches.LaunchQueryItem = .init()
    
    func fetchLaunch(request: LaunchDetail.FetchLaunch.Request) {
        presenter?.presentLaunchDetail(response: .init(launch: .init(from: launch)))
        fetchDetail(request: .init())
    }
    
    func fetchDetail(request: LaunchDetail.FetchDetail.Request) {
        
        presenter?.presentLoader(response: .init(loading: true))

        worker?.fetchDetail(
            query: .init(id: launch.launchID), completion: { [weak presenter] result in
                switch result {
                case .success(let response):
                    presenter?.presentLoader(response: .init(loading: false))
                    presenter?.presentLaunchDetail(response: .init(launch: response))
                case .failure(let error):
                    presenter?.presentLoader(response: .init(loading: false))
                    presenter?.presentError(message: error.localizedDescription)
                }
            }
        )
    }
}
