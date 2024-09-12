//
//  UIApplicationExtension.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

extension UIApplication {
    static let appVersion: String = {
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return appVersion
        } else {
            return ""
        }
    }()

    static let appBuild: String = {
        if let appBuild = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
            return appBuild
        } else {
            return ""
        }
    }()
}
