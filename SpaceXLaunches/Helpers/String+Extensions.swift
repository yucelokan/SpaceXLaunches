//
//  String+Extensions.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation

extension String {
    var localizeIt: String {
        return NSLocalizedString(self, comment: "")
    }
}
