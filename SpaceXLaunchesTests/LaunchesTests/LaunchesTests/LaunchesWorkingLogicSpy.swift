//
//  LaunchesWorkingLogicSpy.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 23.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import SpaceXLaunches
import XCTest
import API

final class LaunchesWorkingLogicSpy: LaunchesWorkingLogic {
    func fetchLaunches(
        query: LaunchesQueryQuery,
        completion: @escaping (Result<[Launches.LaunchQueryItem], Error>) -> Void
    ) {
        Stubber.fetchResponse(fileName: "launches", query: query) { result in
            switch result {
            case .success(let response):
                completion(.success(response.launches?.compactMap({$0}) ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelFetchingLaunches() { }
    
}
