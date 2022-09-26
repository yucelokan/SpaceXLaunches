//
//  UATConfiguration.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 20.06.2022.
//

import Foundation
import API

struct UATConfiguration: AppConfigurationLogic {
    func configure() {
        API.shared.isDeveloperMode = true
    }
}
