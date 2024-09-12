//
//  RequestRetriers.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Foundation

// MARK: - RequestRetrierProtocol -

protocol RequestRetrierProtocol {
    var build: RequestRetrier { get }
}

// MARK: - RequestRetriers -

enum RequestRetriers: RequestRetrierProtocol {
    case `default`

    enum Retriers {
        static let defaultRequestRetrier = DefaultRequestRetrier()
    }

    var build: RequestRetrier {
        switch self {
        case .default:
            return Retriers.defaultRequestRetrier
        }
    }
}
