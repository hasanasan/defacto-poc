//
//  DictionaryExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import Foundation

extension Dictionary {
    var toJSONString: String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
