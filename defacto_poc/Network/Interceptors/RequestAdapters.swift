//
//  RequestAdapters.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Foundation

// MARK: - RequestAdapterProtocol -

protocol RequestAdapterProtocol {
    var build: RequestAdapter { get }
}

// MARK: - RequestAdapters -

enum RequestAdapters: RequestAdapterProtocol {
    case authAdapter

    enum Adapters {
        static let authAdapter = DefaultRequestAdapter()
    }

    var build: RequestAdapter {
        switch self {
        case .authAdapter:
            return Adapters.authAdapter
        }
    }
}
