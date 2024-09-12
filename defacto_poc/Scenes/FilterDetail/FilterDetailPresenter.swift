//
//  FilterDetailPresenter.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - FilterDetailPresentationLogic -

protocol FilterDetailPresentationLogic: AnyObject {
    func presentFilterDetailList(response: FilterDetail.List.Response)
}

// MARK: - FilterDetailPresenter -

final class FilterDetailPresenter {
    weak var viewController: FilterDetailDisplayLogic?
}

// MARK: - FilterDetailPresentationLogic -

extension FilterDetailPresenter: FilterDetailPresentationLogic {
    func presentFilterDetailList(response: FilterDetail.List.Response) {
        let data: [FilterDetailItemCellViewModel] = response.filterModel?.sfi?.map { item in
            FilterDetailItemCellViewModel(id: item.i, title: item.t, isSelected: item.s ?? false)
        } ?? []

        let hasSelectedFilters = data.first { $0.isSelected } != nil
        let viewModel = FilterDetail.List.ViewModel(pageTitle: response.filterModel?.fn,
                                                    hasSelectedFilters: hasSelectedFilters,
                                                    data: data)
        viewController?.displayFilterDetailList(viewModel: viewModel)
    }
}
