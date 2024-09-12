//
//  RequestObject.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Foundation

struct RequestObject {
    // MARK: - Lifecycle -

    init(url: String,
         method: HTTPMethod = .get,
         data: Encodable? = nil,
         headers: [String: String]? = nil,
         encoding: URLEncoding = .default,
         requestInterceptor: Interceptor? = nil)
    {
        self.url = url
        self.method = method
        self.data = data
        self.headers = headers
        self.encoding = encoding
        self.requestInterceptor = requestInterceptor
    }

    // MARK: - Internal -

    var url: String
    let method: HTTPMethod
    var data: Encodable?
    var headers: [String: String]?
    var encoding: URLEncoding
    var requestInterceptor: Interceptor?
}
