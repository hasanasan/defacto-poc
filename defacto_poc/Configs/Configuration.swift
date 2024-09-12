//
//  Configuration.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

enum Configuration {
    static var isProduction: Bool {
        #if Production
        return true
        #else
        return false
        #endif
    }

    static var isAppStore: Bool {
        #if AppStore
        return true
        #else
        return false
        #endif
    }

    static var isDevelopment: Bool {
        #if Development
        return true
        #else
        return false
        #endif
    }

    static var baseURL: String {
        let url: String? = Bundle.infoDictionaryValue(for: "API_BASE_URL")
        return url ?? ""
    }
}
