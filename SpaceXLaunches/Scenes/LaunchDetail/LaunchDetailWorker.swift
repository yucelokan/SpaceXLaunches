//
//  LaunchDetailWorker.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation
import API

protocol LaunchDetailWorkingLogic: AnyObject {
    func fetchDetail(
        query: LaunchDetailQueryQuery,
        completion: @escaping (Result<LaunchDetail.LaunchDetailQueryItem, Error>) -> Void
    )
    func cancelFetchingLaunches()
}

final class LaunchDetailWorker: LaunchDetailWorkingLogic {
    
    func fetchDetail(
        query: LaunchDetailQueryQuery,
        completion: @escaping (Result<LaunchDetail.LaunchDetailQueryItem, Error>) -> Void
    ) {
        API.SpaceX.detail.fetchResponse(query: query) { result in
            switch result {
            case .success(let response):
                guard let launch = response.launch else {
                    completion(.failure(NSError(domain: "no data", code: -1)))
                    return
                }
                completion(.success(launch))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelFetchingLaunches() {
        API.shared.clients["LaunchDetailQueryQuery"]?.cancel()
    }
}
