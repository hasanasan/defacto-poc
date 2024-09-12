//
//  ProductService.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Alamofire
import Combine
import Foundation

// MARK: - ProductServiceProtocol -

protocol ProductServiceProtocol {
    func searchCatalogRequest(filters: String?,
                              pageSize: Int,
                              pageIndex: Int,
                              sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>

    func searchFacetRequest(filters: String?,
                            pageSize: Int,
                            pageIndex: Int,
                            sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
}

// MARK: - ProductService -

class ProductService: ProductServiceProtocol, AdessoServiceProtocol {
    // MARK: - Lifecycle -

    init(baseService: BaseServiceProtocol = BaseServiceProvider.shared.baseService) {
        self.baseService = baseService
    }

    // MARK: - Internal -

    typealias Endpoint = ProductServiceEndpoint

    let baseService: BaseServiceProtocol

    func searchCatalogRequest(filters: String?,
                              pageSize: Int,
                              pageIndex: Int,
                              sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        request(with: RequestObject(url: build(endpoint: .searchCatalog(filters: filters,
                                                                        pageSize: pageSize,
                                                                        pageIndex: pageIndex,
                                                                        sortingOptionId: sortingOptionId)),
                                    headers: commonHeaders))
    }

    func searchFacetRequest(filters: String?, pageSize: Int, pageIndex: Int,
                            sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        request(with: RequestObject(url: build(endpoint: .searchCatalog(filters: filters,
                                                                        pageSize: pageSize,
                                                                        pageIndex: pageIndex,
                                                                        sortingOptionId: sortingOptionId)),
                                    headers: commonHeaders))
    }

    // MARK: - Private -

    private let commonHeaders: [String: String] = ["sw": "390",
                                                   "mid": "BD1D7667-4291-40F8-BF0F-90562C5796DA",
                                                   "sh": "844",
                                                   "spr": "3.0",
                                                   "cl": "1",
                                                   "dt": "101314",
                                                   "did": "21BC0789-E841-415B-A49F-776969D0259D",
                                                   "xak": "6a9775962c40526afc816e3dc061b6368c53154a792d0f00adb44a538a3abfbdb19baa4260019588ffb5b41e93ff8829518be5892601a82835f474dff97222b4",
                                                   "v": "4.82.1",
                                                   "rid": "1",
                                                   "cid": "1"]
}
