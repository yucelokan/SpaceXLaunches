//
//  LaunchDetailWorkingLogicSpy.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import SpaceXLaunches
import XCTest
import API

final class LaunchDetailWorkingLogicSpy: LaunchDetailWorkingLogic {
    func fetchDetail(
        query: LaunchDetailQueryQuery,
        completion: @escaping (Result<LaunchDetail.LaunchDetailQueryItem, Error>) -> Void
    ) {
        Stubber.fetchResponse(fileName: "launchDetail", query: query) { result in
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
    
    func cancelFetchingLaunches() { }
}
