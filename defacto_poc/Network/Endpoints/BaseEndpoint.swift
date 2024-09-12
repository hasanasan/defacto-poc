//
//  BaseEndpoint.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

enum BaseEndpoint: TargetEndpointProtocol {
    case base

    var path: String {
        switch self {
        case .base:
            return Configuration.baseURL
        }
    }
}
