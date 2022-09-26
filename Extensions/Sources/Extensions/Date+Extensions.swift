//
//  Date+Extensions.swift
//  
//
//  Created by okan.yucel on 22.06.2022.
//

import Foundation

public extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
