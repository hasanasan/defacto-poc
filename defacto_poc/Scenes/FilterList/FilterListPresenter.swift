//
//  FilterListPresenter.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - FilterListPresentationLogic -

protocol FilterListPresentationLogic: AnyObject {
    func presentFilterList(response: FilterList.List.Response)
    func presentFilterDetails()
}

// MARK: - FilterListPresenter -

final class FilterListPresenter {
    weak var viewController: FilterListDisplayLogic?
}

// MARK: - FilterListPresentationLogic -

extension FilterListPresenter: FilterListPresentationLogic {
    func presentFilterList(response: FilterList.List.Response) {
        let data = response.responseModel?.getFilteringOptions()?.map {
            FilterItemCellViewModel(id: $0.fk, title: $0.fn, isSelected: false, displayOrder: $0.displayOrder, uniquId: $0.fid)
        } ?? []

        let hasSelectedFilters = response.responseModel?.getSelectedFilters().isEmpty == false
        let viewModel = FilterList.List.ViewModel(productCount: response.responseModel?.d?.c ?? 0,
                                                  hasSelectedFilters: hasSelectedFilters,
                                                  data: data)
        viewController?.displayFilterList(viewModel: viewModel)
    }

    func presentFilterDetails() {
        viewController?.displayFilterDetails()
    }
}
