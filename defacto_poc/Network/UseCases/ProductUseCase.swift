//
//  ProductUseCase.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Combine
import Foundation

// MARK: - ProductUseCaseProtocol -

protocol ProductUseCaseProtocol {
    func fetchSearchCatalog(filters: String?,
                            pageSize: Int,
                            pageIndex: Int,
                            sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
    func fetchSearchFacet(filters: String?,
                          pageSize: Int,
                          pageIndex: Int,
                          sortingOptionId: String?) -> AnyPublisher<ProductListResponseModel, AdessoError>
}

// MARK: - ProductUseCase -

class ProductUseCase: ProductUseCaseProtocol {
    // MARK: - Lifecycle -

    init(productRepository: ProductRepositoryProtocol = ProductRepository()) {
        self.productRepository = productRepository
    }

    // MARK: - Internal -

    let productRepository: ProductRepositoryProtocol

    func fetchSearchCatalog(filters: String?,
                            pageSize: Int,
                            pageIndex: Int,
                            sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        productRepository.getSearchCatalog(filters: filters,
                                           pageSize: pageSize,
                                           pageIndex: pageIndex,
                                           sortingOptionId: sortingOptionId)
    }

    func fetchSearchFacet(filters: String?,
                          pageSize: Int,
                          pageIndex: Int,
                          sortingOptionId: String?)
        -> AnyPublisher<ProductListResponseModel, AdessoError>
    {
        productRepository.getSearchFacet(filters: filters,
                                         pageSize: pageSize,
                                         pageIndex: pageIndex,
                                         sortingOptionId: sortingOptionId)
    }
}
