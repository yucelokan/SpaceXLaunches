//
//  LaunchesWorker.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import Foundation
import API

protocol LaunchesWorkingLogic: AnyObject {
    func fetchLaunches(
        query: LaunchesQueryQuery,
        completion: @escaping (Result<[Launches.LaunchQueryItem], Error>) -> Void
    )
    func cancelFetchingLaunches()
}

final class LaunchesWorker: LaunchesWorkingLogic {
    func fetchLaunches(
        query: LaunchesQueryQuery,
        completion: @escaping (Result<[Launches.LaunchQueryItem], Error>) -> Void
    ) {
        API.SpaceX.launches.fetchResponse(query: query) { result in
            switch result {
            case .success(let response):
                completion(.success(response.launches?.compactMap({$0}) ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelFetchingLaunches() {
        API.shared.clients["LaunchesQueryQuery"]?.cancel()
    }
}
