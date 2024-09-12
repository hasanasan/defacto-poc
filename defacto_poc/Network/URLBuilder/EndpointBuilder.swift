//
//  EndpointBuilder.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

class EndpointBuilder {
    // MARK: - Lifecycle -

    init() { }

    // MARK: - Internal -

    func build(with targetEndpoint: some TargetEndpointProtocol) -> String {
        targetEndpoint.path
    }
}
