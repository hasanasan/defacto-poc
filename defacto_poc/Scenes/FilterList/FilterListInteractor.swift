//
//  FilterListInteractor.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - FilterListBusinessLogic -

protocol FilterListBusinessLogic: AnyObject {
    func viewDidLoad()
    func didSelectFilter(request: FilterList.List.Request)
    func didTapClear()
    func didApplySubFilters(filterModel: F?)
}

// MARK: - FilterListDataStore -

protocol FilterListDataStore: AnyObject {
    var productListResponseModel: ProductListResponseModel? { get set }
    var selectedFilterModel: F? { get set }
}

// MARK: - FilterListInteractor -

final class FilterListInteractor {
    // MARK: - Lifecycle -

    init(worker: FilterListWorkProtocol) {
        self.worker = worker
    }

    // MARK: - Internal -

    var presenter: FilterListPresentationLogic?
    var productListResponseModel: ProductListResponseModel?
    var selectedFilterModel: F?

    // MARK: - Private -

    private var worker: FilterListWorkProtocol
    private var pageSize = 36
    private var pageIndex = 1
}

// MARK: - FilterListBusinessLogic, FilterListDataStore -

extension FilterListInteractor: FilterListBusinessLogic, FilterListDataStore {
    // MARK: - Internal -

    func viewDidLoad() {
        showFilters()
    }

    func didSelectFilter(request: FilterList.List.Request) {
        if let filter = (productListResponseModel?.getFilteringOptions()?
            .first { $0.fk == request.id && $0.displayOrder == request.displayOrder && $0.fid == request.uniquId })
        {
            selectedFilterModel = filter
            presenter?.presentFilterDetails()
        }
    }

    func didTapClear() {
        productListResponseModel?.clearSelectedFilters()

        getProductList(filterData: [:], pageSize: pageSize, pageIndex: pageIndex)
    }

    func didApplySubFilters(filterModel: F?) {
        if let model = filterModel,
           let index = (productListResponseModel?.d?.f?.firstIndex { $0.fid == model.fid && $0.fk == model.fk })
        {
            productListResponseModel?.d?.f?[index] = model
        }

        let filters = productListResponseModel?.getSelectedFilters() ?? [:]
        getProductList(filterData: filters, pageSize: pageSize, pageIndex: pageIndex)
    }

    // MARK: - Private -

    private func showFilters() {
        let response = FilterList.List.Response(responseModel: productListResponseModel)
        presenter?.presentFilterList(response: response)
    }
}

extension FilterListInteractor {
    private func getProductList(filterData: [String: [String]], pageSize: Int, pageIndex: Int) {
        LoadingIndicatorHelper.show()
        worker.getProductList(filterData: filterData,
                              pageSize: pageSize,
                              pageIndex: pageIndex)
        { [weak self] result in
            LoadingIndicatorHelper.hide()

            switch result {
            case .success(let responseModel):
                self?.productListResponseModel = responseModel

                self?.showFilters()
            case .failure(let error):
                Logger().log(level: .debug, message: error.localizedDescription)
            }
        }
    }
}
