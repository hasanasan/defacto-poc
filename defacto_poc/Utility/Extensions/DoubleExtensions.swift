//
//  DoubleExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import Foundation

extension Double {
    func toInt() -> Int {
        Int(self)
    }

    func toString(decimalCount: Int = 2) -> String {
        if truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        }

        return String(format: "%.\(decimalCount)f", self)
    }
}

extension Double? {
    func toString(decimalCount: Int = 2, stringIfNil: String = "") -> String {
        guard let self else {
            return stringIfNil
        }

        return self.toString(decimalCount: decimalCount)
    }
}
