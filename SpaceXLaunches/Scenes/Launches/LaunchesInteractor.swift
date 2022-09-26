//
//  LaunchesInteractor.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import UIKit
import API
import RxRelay
import RxSwift

protocol LaunchesBusinessLogic: AnyObject {
    func fetchLaunches(request: Launches.FetchLaunches.Request)
    func fetchMoreLaunches(request: Launches.FetchLaunches.RequestMore)
    func subscribeLaunches(request: Launches.SubscribeLaunches.Request)
    func fetchLaunchDetail(request: Launches.Select.Request)
}

protocol LaunchesDataStore: AnyObject {
    
}

final class LaunchesInteractor: LaunchesBusinessLogic, LaunchesDataStore {
    
    var presenter: LaunchesPresentationLogic?
    var worker: LaunchesWorkingLogic?
    
    private var launchesRequest = Launches.FetchLaunches.Request(offset: 0)
    private var launches: BehaviorRelay<[Launches.LaunchQueryItem]> = .init(value: [])
    private var disposeBag = DisposeBag()
    
    init(worker: LaunchesWorkingLogic) {
        self.worker = worker
    }
    
    func fetchLaunchDetail(request: Launches.Select.Request) {
        presenter?.presentDetail(response: .init(launch: launches.value[request.index]))
    }
    
    func subscribeLaunches(request: Launches.SubscribeLaunches.Request) {
        launches.subscribe { [weak presenter] items in
            presenter?.presentSnapshot(response: .init(launches: items))
        }.disposed(by: disposeBag)
    }
    
    func fetchMoreLaunches(request: Launches.FetchLaunches.RequestMore) {
        launchesRequest.offset = launches.value.count
        presenter?.presentLoader(response: .init(loaders: [
            .footer(true), .pullToRefresh(false)
        ]))
        fetch(request: launchesRequest)
    }
    
    func fetchLaunches(request: Launches.FetchLaunches.Request) {
        worker?.cancelFetchingLaunches()
        launches.accept([])
        let newRequest: Launches.FetchLaunches.Request = .init(offset: 0)
        presenter?.presentLoader(response: .init(loaders: [
            .footer(false), .pullToRefresh(true)
        ]))
        fetch(request: newRequest)
    }
    
    private func fetch(request: Launches.FetchLaunches.Request) {
        launchesRequest = request
        guard launchesRequest.status == .available else {
            presenter?.presentLoader(response: .init(loaders: [
                .footer(false), .pullToRefresh(false)
            ]))
            return
        }
        
        launchesRequest.status = .fetching
        worker?.fetchLaunches(query: request.query, completion: { [weak self] result in
            switch result {
            case .success(let response):
                let oldValues = self?.launches.value ?? []
                self?.launches.accept(oldValues + response)
                self?.launchesRequest.status.update(with: response.count)
                self?.presenter?.presentLoader(response: .init(loaders: [
                    .footer(false), .pullToRefresh(false)
                ]))
            case .failure(let error):
                self?.presenter?.presentLoader(response: .init(loaders: [
                    .footer(false), .pullToRefresh(false)
                ]))
                self?.presenter?.presentError(message: error.localizedDescription)
            }
        })
    }
}
