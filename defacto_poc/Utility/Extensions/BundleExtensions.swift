//
//  BundleExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

extension Bundle {
    static func infoDictionaryValue<T>(for key: String) -> T? {
        Bundle.main.object(forInfoDictionaryKey: key) as? T
    }
}
