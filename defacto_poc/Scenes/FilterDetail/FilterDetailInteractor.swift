//
//  FilterDetailInteractor.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - FilterDetailBusinessLogic -

protocol FilterDetailBusinessLogic: AnyObject {
    func viewDidLoad()
    func didUpdateFilter(request: FilterDetail.List.Request)
    func didTapClear()
}

// MARK: - FilterDetailDataStore -

protocol FilterDetailDataStore: AnyObject {
    var selectedFilterModel: F? { get set }
}

// MARK: - FilterDetailInteractor -

final class FilterDetailInteractor {
    // MARK: - Lifecycle -

    init(worker: FilterDetailWorkProtocol) {
        self.worker = worker
    }

    // MARK: - Internal -

    var presenter: FilterDetailPresentationLogic?
    var selectedFilterModel: F?

    // MARK: - Private -

    private var worker: FilterDetailWorkProtocol
}

// MARK: - FilterDetailBusinessLogic, FilterDetailDataStore -

extension FilterDetailInteractor: FilterDetailBusinessLogic, FilterDetailDataStore {
    // MARK: - Internal -

    func viewDidLoad() {
        showFilterDetails()
    }

    func didUpdateFilter(request: FilterDetail.List.Request) {
        if let index = (selectedFilterModel?.sfi?.firstIndex { $0.i == request.filterId }) {
            selectedFilterModel?.sfi?[index].s = request.isSelected
        }

        showFilterDetails()
    }

    func didTapClear() {
        for index in (selectedFilterModel?.sfi ?? []).indices {
            selectedFilterModel?.sfi?[index].s = false
        }

        showFilterDetails()
    }

    // MARK: - Private -

    private func showFilterDetails() {
        let response = FilterDetail.List.Response(filterModel: selectedFilterModel)
        presenter?.presentFilterDetailList(response: response)
    }
}

extension FilterDetailInteractor { }
