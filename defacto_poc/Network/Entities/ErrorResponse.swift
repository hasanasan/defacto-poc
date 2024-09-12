//
//  ErrorResponse.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

class ErrorResponse: Decodable {
    var code: Int?
    var message: String?
    var messages: [String: String]?
}
