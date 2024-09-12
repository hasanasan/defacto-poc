//
//  ProductRemoteDataSource.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Combine
import Foundation

// MARK: - ProductRemoteDataSourceProtocol -

protocol ProductRemoteDataSourceProtocol {
    func getSearchCatalog(filters: String?,
                          pageSize: Int,
                          pageIndex: Int,
                          sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
    func getSearchFacet(filters: String?,
                        pageSize: Int,
                        pageIndex: Int,
                        sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
}

// MARK: - ProductRemoteDataSource -

class ProductRemoteDataSource: ProductRemoteDataSourceProtocol {
    // MARK: - Lifecycle -

    init(productService: ProductServiceProtocol = WebServiceProvider.shared.productService) {
        self.productService = productService
    }

    // MARK: - Internal -

    let productService: ProductServiceProtocol

    func getSearchCatalog(filters: String?,
                          pageSize: Int,
                          pageIndex: Int,
                          sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        productService.searchCatalogRequest(filters: filters,
                                            pageSize: pageSize,
                                            pageIndex: pageIndex,
                                            sortingOptionId: sortingOptionId)
    }

    func getSearchFacet(filters: String?,
                        pageSize: Int,
                        pageIndex: Int,
                        sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        productService.searchFacetRequest(filters: filters,
                                          pageSize: pageSize,
                                          pageIndex: pageIndex,
                                          sortingOptionId: sortingOptionId)
    }
}
