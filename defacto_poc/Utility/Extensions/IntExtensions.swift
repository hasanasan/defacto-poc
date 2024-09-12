//
//  IntExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import Foundation

extension Int {
    func toString() -> String {
        "\(self)"
    }

    func toDouble() -> Double {
        Double(self)
    }
}

extension Int? {
    func toString(stringIfNil: String = "") -> String {
        guard let self else {
            return stringIfNil
        }

        return "\(self)"
    }
}
