//
//  ProductListInteractor.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - ProductListBusinessLogic -

protocol ProductListBusinessLogic: AnyObject {
    func viewDidLoad()
    func didChangeSorting(request: ProductList.Sort.Request)
    func loadMore()
    func didSelectCategory(request: ProductList.List.Request)
    func didApplyFilters(responseModel: ProductListResponseModel?)
}

// MARK: - ProductListDataStore -

protocol ProductListDataStore: AnyObject {
    var productListResponseModel: ProductListResponseModel? { get set }
}

// MARK: - ProductListInteractor -

final class ProductListInteractor {
    // MARK: - Lifecycle -

    init(worker: ProductListWorkProtocol) {
        self.worker = worker
    }

    // MARK: - Internal -

    var presenter: ProductListPresentationLogic?
    var productListResponseModel: ProductListResponseModel?

    // MARK: - Private -

    private var isLoading: Bool = false
    private var worker: ProductListWorkProtocol
    private var pageSize = 36
    private var pageIndex = 1
    private var selectedSortingOptionId: String?
    private var selectedFilters: [String: [String]] = [:]
}

// MARK: - ProductListBusinessLogic, ProductListDataStore -

extension ProductListInteractor: ProductListBusinessLogic, ProductListDataStore {
    // MARK: - Internal -

    func viewDidLoad() {
        reload()
    }

    func didChangeSorting(request: ProductList.Sort.Request) {
        selectedSortingOptionId = request.selectedId
        pageIndex = 1

        reload()
    }

    func didSelectCategory(request: ProductList.List.Request) {
        pageIndex = 1
        selectedSortingOptionId = nil
        productListResponseModel?.toggleCategoryFilter(categoryId: request.categoryId)
        selectedFilters = productListResponseModel?.getSelectedFilters() ?? [:]

        reload()
    }

    func loadMore() {
        if isLoading == true {
            return
        }

        searchCatalog(filterData: selectedFilters,
                      pageSize: pageSize,
                      pageIndex: pageIndex,
                      sortingOptionId: selectedSortingOptionId,
                      isLoadMore: true)
    }

    func didApplyFilters(responseModel: ProductListResponseModel?) {
        selectedFilters = responseModel?.getSelectedFilters() ?? [:]
        selectedSortingOptionId = nil
        pageIndex = 1

        reload()
    }

    // MARK: - Private -

    private func showProducts() {
        selectedFilters = productListResponseModel?.getSelectedFilters() ?? [:]

        let response = ProductList.List.Response(responseModel: productListResponseModel,
                                                 selectedSortingOptionId: selectedSortingOptionId)
        presenter?.presentProductList(response: response)
    }

    private func reload() {
        searchCatalog(filterData: selectedFilters,
                      pageSize: pageSize,
                      pageIndex: pageIndex,
                      sortingOptionId: selectedSortingOptionId,
                      isLoadMore: false)
    }
}

extension ProductListInteractor {
    private func searchCatalog(filterData: [String: [String]],
                               pageSize: Int,
                               pageIndex: Int,
                               sortingOptionId: String? = nil,
                               isLoadMore: Bool = false)
    {
        isLoading = true

        if isLoadMore == false {
            LoadingIndicatorHelper.show()
        }

        worker.searchCatalog(filterData: filterData,
                             pageSize: pageSize,
                             pageIndex: pageIndex,
                             sortingOptionId: sortingOptionId)
        { [weak self] result in
            self?.isLoading = false

            if isLoadMore == false {
                LoadingIndicatorHelper.hide()
            }

            switch result {
            case .success(let responseModel):
                if isLoadMore == false {
                    self?.productListResponseModel = responseModel

                    self?.showProducts()
                } else {
                    let response = ProductList.Append.Response(responseModel: responseModel)
                    self?.presenter?.presentAppendProducts(response: response)
                }

                self?.pageIndex += 1
            case .failure(let error):
                Logger().log(level: .debug, message: error.localizedDescription)
            }
        }
    }
}
