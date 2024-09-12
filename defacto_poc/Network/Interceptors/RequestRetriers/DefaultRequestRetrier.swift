//
//  DefaultRequestRetrier.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Foundation

class DefaultRequestRetrier: RequestRetrier {
    func retry(_: Request, for _: Session, dueTo _: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
