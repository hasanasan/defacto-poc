//
//  FilterDetailRouter.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - FilterDetailNavigationOption -

enum FilterDetailNavigationOption {
    case popToParent
}

// MARK: - FilterDetailRoutingLogic -

protocol FilterDetailRoutingLogic {
    func navigate(to option: FilterDetailNavigationOption)
}

// MARK: - FilterDetailDataPassing -

protocol FilterDetailDataPassing: AnyObject {
    var dataStore: FilterDetailDataStore? { get }
}

// MARK: - FilterDetailRouter -

final class FilterDetailRouter: NSObject, FilterDetailDataPassing {
    weak var viewController: FilterDetailViewController?
    var dataStore: FilterDetailDataStore?
}

// MARK: - FilterDetailRoutingLogic -

extension FilterDetailRouter: FilterDetailRoutingLogic {
    func navigate(to option: FilterDetailNavigationOption) {
        switch option {
        case .popToParent:
            viewController?.delegate?.didApplyFilters(viewController, filterModel: dataStore?.selectedFilterModel)
        }
    }
}
