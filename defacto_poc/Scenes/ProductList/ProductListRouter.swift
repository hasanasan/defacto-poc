//
//  ProductListRouter.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - ProductListNavigationOption -

enum ProductListNavigationOption {
    case filterList
}

// MARK: - ProductListRoutingLogic -

protocol ProductListRoutingLogic {
    func navigate(to option: ProductListNavigationOption)
}

// MARK: - ProductListDataPassing -

protocol ProductListDataPassing: AnyObject {
    var dataStore: ProductListDataStore? { get }
}

// MARK: - ProductListRouter -

final class ProductListRouter: NSObject, ProductListDataPassing {
    weak var viewController: ProductListViewController?
    var dataStore: ProductListDataStore?
}

// MARK: - ProductListRoutingLogic -

extension ProductListRouter: ProductListRoutingLogic {
    func navigate(to option: ProductListNavigationOption) {
        switch option {
        case .filterList:
            let worker = FilterListWorker()
            let destinationVC = FilterListViewController(worker: worker)
            destinationVC.delegate = self

            let destinationDS = destinationVC.router?.dataStore
            destinationDS?.productListResponseModel = dataStore?.productListResponseModel

            let navigationController = UINavigationController(rootViewController: destinationVC)
            navigationController.navigationBar.tintColor = .black
            navigationController.modalPresentationStyle = .fullScreen
            viewController?.present(navigationController, animated: true)
        }
    }
}

// MARK: - FilterListViewControllerDelegate -

extension ProductListRouter: FilterListViewControllerDelegate {
    func didApplyFilters(_: FilterListViewController?, responseModel: ProductListResponseModel?) {
        viewController?.interactor?.didApplyFilters(responseModel: responseModel)
    }
}
