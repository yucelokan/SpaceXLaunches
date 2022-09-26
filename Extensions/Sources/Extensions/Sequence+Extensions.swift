//
//  File.swift
//  
//
//  Created by okan.yucel on 23.06.2022.
//

import Foundation

public extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
