//
//  SplashInteractor.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import Foundation

protocol SplashBusinessLogic: AnyObject {
    
}

protocol SplashDataStore: AnyObject {
    
}

final class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    
    var presenter: SplashPresentationLogic?
    var worker: SplashWorkingLogic?
    
    init(worker: SplashWorkingLogic) {
        self.worker = worker
    }
}
