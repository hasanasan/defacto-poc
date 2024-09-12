//
//  BaseServiceProtocol.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Combine
import Foundation

// MARK: - BaseServiceProtocol -

protocol BaseServiceProtocol {
    func request<T: Decodable>(with requestObject: RequestObject,
                               receiveOn queue: DispatchQueue,
                               retries: Int,
                               decoder: JSONDecoder) -> AnyPublisher<T, AdessoError>
}

extension BaseServiceProtocol {
    func request<T: Decodable>(with requestObject: RequestObject,
                               receiveOn queue: DispatchQueue = .main,
                               retries: Int = 1,
                               decoder: JSONDecoder = JSONDecoder())
        -> AnyPublisher<T, AdessoError>
    {
        request(with: requestObject,
                receiveOn: queue,
                retries: retries,
                decoder: decoder)
    }
}
