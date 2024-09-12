//
//  FilterListRouter.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - FilterListNavigationOption -

enum FilterListNavigationOption {
    case filterDetail
    case productList(delegate: FilterListViewControllerDelegate?)
}

// MARK: - FilterListRoutingLogic -

protocol FilterListRoutingLogic {
    func navigate(to option: FilterListNavigationOption)
}

// MARK: - FilterListDataPassing -

protocol FilterListDataPassing: AnyObject {
    var dataStore: FilterListDataStore? { get }
}

// MARK: - FilterListRouter -

final class FilterListRouter: NSObject, FilterListDataPassing {
    weak var viewController: FilterListViewController?
    var dataStore: FilterListDataStore?
}

// MARK: - FilterListRoutingLogic -

extension FilterListRouter: FilterListRoutingLogic {
    func navigate(to option: FilterListNavigationOption) {
        switch option {
        case .filterDetail:
            let worker = FilterDetailWorker()
            let destinationVC = FilterDetailViewController(worker: worker)
            destinationVC.delegate = self

            let destinationDS = destinationVC.router?.dataStore
            destinationDS?.selectedFilterModel = dataStore?.selectedFilterModel

            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        case .productList(let delegate):
            viewController?.navigationController?.dismiss(animated: true, completion: {
                delegate?.didApplyFilters(self.viewController, responseModel: self.dataStore?.productListResponseModel)
            })
        }
    }
}

// MARK: - FilterDetailViewControllerDelegate -

extension FilterListRouter: FilterDetailViewControllerDelegate {
    func didApplyFilters(_ controller: FilterDetailViewController?, filterModel: F?) {
        viewController?.interactor?.didApplySubFilters(filterModel: filterModel)
        controller?.navigationController?.popViewController(animated: true)
    }
}
