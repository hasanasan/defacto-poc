//
//  FilterListWorker.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Combine
import Foundation

// MARK: - FilterListWorkProtocol -

protocol FilterListWorkProtocol {
    func getProductList(filterData: [String: [String]],
                        pageSize: Int,
                        pageIndex: Int,
                        completion: RequestCompletionBlock<ProductListResponseModel>)
}

// MARK: - FilterListWorker -

final class FilterListWorker: FilterListWorkProtocol {
    // MARK: - Internal -

    func getProductList(filterData: [String: [String]],
                        pageSize: Int,
                        pageIndex: Int,
                        completion: RequestCompletionBlock<ProductListResponseModel>)
    {
        let filters = filterData.map { key, value in
            "\(key)=\(value.joined(separator: "-"))"
        }.joined(separator: "&")

        let productUseCase: ProductUseCaseProtocol = ProductUseCase()
        productUseCase.fetchSearchFacet(filters: filters,
                                        pageSize: pageSize,
                                        pageIndex: pageIndex,
                                        sortingOptionId: nil)
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

// MARK: - FilterListWorkerSpy -

final class FilterListWorkerSpy: FilterListWorkProtocol {
    func getProductList(filterData: [String: [String]],
                        pageSize: Int,
                        pageIndex: Int,
                        completion: RequestCompletionBlock<ProductListResponseModel>) { }
}
