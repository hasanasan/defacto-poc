//
//  ProductRepository.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Combine
import Foundation

// MARK: - ProductRepositoryProtocol -

protocol ProductRepositoryProtocol {
    func getSearchCatalog(filters: String?,
                          pageSize: Int,
                          pageIndex: Int,
                          sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
    func getSearchFacet(filters: String?,
                        pageSize: Int,
                        pageIndex: Int,
                        sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
}

// MARK: - ProductRepository -

class ProductRepository: ProductRepositoryProtocol {
    // MARK: - Lifecycle -

    init(productRemoteDataSource: ProductRemoteDataSourceProtocol = ProductRemoteDataSource()) {
        self.productRemoteDataSource = productRemoteDataSource
    }

    // MARK: - Internal -

    let productRemoteDataSource: ProductRemoteDataSourceProtocol

    func getSearchCatalog(filters: String?,
                          pageSize: Int,
                          pageIndex: Int,
                          sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        productRemoteDataSource.getSearchCatalog(filters: filters,
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
        productRemoteDataSource.getSearchFacet(filters: filters,
                                               pageSize: pageSize,
                                               pageIndex: pageIndex,
                                               sortingOptionId: sortingOptionId)
    }
}
