//
//  Logger.swift
//  SpaceXLaunches
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation
import Extensions

enum Logger {
    static func info(_ message: String) {
        guard AppConfiguration.type == .development else { return }
        print("\n\n[\(Date().string(with: "yyyy-MM-dd HH:mm:ss"))]\n\(message)")
    }
}
