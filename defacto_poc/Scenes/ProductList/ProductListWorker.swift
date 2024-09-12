//
//  ProductListWorker.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Combine
import Foundation

// MARK: - ProductListWorkProtocol -

protocol ProductListWorkProtocol {
    func searchCatalog(filterData: [String: [String]],
                       pageSize: Int,
                       pageIndex: Int,
                       sortingOptionId: String?,
                       completion: RequestCompletionBlock<ProductListResponseModel>)
}

// MARK: - ProductListWorker -

final class ProductListWorker: ProductListWorkProtocol {
    // MARK: - Internal -

    func searchCatalog(filterData: [String: [String]],
                       pageSize: Int,
                       pageIndex: Int,
                       sortingOptionId: String?,
                       completion: RequestCompletionBlock<ProductListResponseModel>)
    {
        let filters = filterData.map { key, value in
            "\(key)=\(value.joined(separator: "-"))"
        }.joined(separator: "&")

        let productUseCase: ProductUseCaseProtocol = ProductUseCase()
        productUseCase.fetchSearchCatalog(filters: filters,
                                          pageSize: pageSize,
                                          pageIndex: pageIndex,
                                          sortingOptionId: sortingOptionId)
            .sink { result in
                switch result {
                case .failure(let error):
                    completion?(.failure(error))
                default:
                    break
                }
            } receiveValue: { model in
                completion?(.success(model))
            }.store(in: &cancellable)
    }

    // MARK: - Private -

    private var cancellable = Set<AnyCancellable>()
}

// MARK: - ProductListWorkerSpy -

final class ProductListWorkerSpy: ProductListWorkProtocol {
    func searchCatalog(filterData _: [String: [String]],
                       pageSize _: Int,
                       pageIndex _: Int,
                       sortingOptionId _: String?,
                       completion _: RequestCompletionBlock<ProductListResponseModel>) { }
}
