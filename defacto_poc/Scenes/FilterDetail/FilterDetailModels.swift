//
//  FilterDetailModels.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

enum FilterDetail {
    enum List {
        struct Request {
            let filterId: String?
            let isSelected: Bool
        }

        struct Response {
            let filterModel: F?
        }

        struct ViewModel {
            let pageTitle: String?
            let hasSelectedFilters: Bool
            let data: [FilterDetailItemCellViewModel]
        }
    }

    enum Apply {
        struct Request { }

        struct Response {
            let key: String?
            let keyId: String?
            let values: [String]?
        }

        struct ViewModel {
            let key: String
            let keyId: String
            let values: [String]
        }
    }
}
