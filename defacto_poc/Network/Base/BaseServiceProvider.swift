//
//  BaseServiceProvider.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

class BaseServiceProvider {
    // MARK: - Lifecycle -

    private init() {
        baseService = BaseService()
    }

    // MARK: - Internal -

    static let shared: BaseServiceProvider = .init()

    let baseService: BaseServiceProtocol
}
