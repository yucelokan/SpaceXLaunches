//
//  Logger.swift
//  
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation

enum Logger {
    static func info(_ message: String) {
        guard API.shared.isDeveloperMode else { return }
        print("\n\n[\(Date().string(with: "yyyy-MM-dd HH:mm:ss"))]\n\(message)")
    }
}
