//
//  HTTPURLResponseExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var httpStatus: HTTPStatus? {
        HTTPStatus(rawValue: statusCode)
    }
}
