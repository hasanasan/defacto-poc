//
//  WebServiceProvider.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

class WebServiceProvider {
    // MARK: - Lifecycle -

    private init() {
        productService = ProductService()
    }

    // MARK: - Internal -

    static let shared: WebServiceProvider = .init()

    let productService: ProductServiceProtocol
}
