//
//  NetworkResult.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

// MARK: - NetworkResult -

enum NetworkResult<T> {
    case success(T)
    case failure(AdessoError)
}

typealias RequestCompletionBlock<T> = ((NetworkResult<T>) -> Void)?
