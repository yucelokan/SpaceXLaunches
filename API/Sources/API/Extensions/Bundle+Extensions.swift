//
//  Bundle+Extensions.swift
//  
//
//  Created by okan.yucel on 23.06.2022.
//

import Foundation

/// Bundle extension
public extension Bundle {
    /// Returns String value for the specified key from bundle dictionary.
    /// - Parameter key: String representing item key.
    /// - Returns: String value if exists.
    func infoForKey(_ key: String) -> String? {
        (infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
    
}
