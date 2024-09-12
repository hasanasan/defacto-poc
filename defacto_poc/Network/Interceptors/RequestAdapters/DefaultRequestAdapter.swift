//
//  DefaultRequestAdapter.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Foundation

class DefaultRequestAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest, for _: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void)
    {
        completion(.success(urlRequest))
    }
}
