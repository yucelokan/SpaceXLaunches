//
//  String+Extensions.swift
//  
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation

public extension String {
    func date(with format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func date(from fromFormat: String, toFormat: String) -> String {
        return date(with: fromFormat)?.string(with: toFormat) ?? self
    }
}
