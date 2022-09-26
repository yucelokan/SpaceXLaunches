//
//  File.swift
//  
//
//  Created by okan.yucel on 23.06.2022.
//

import Foundation
import Apollo

extension ResultMap {
    var prettyString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
           let string = String(data: data, encoding: String.Encoding.ascii) else {
           return nil
        }
        return string
    }
}
