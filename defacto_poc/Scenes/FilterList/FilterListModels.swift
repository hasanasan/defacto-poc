//
//  FilterListModels.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

enum FilterList {
    enum List {
        struct Request {
            let id: String?
            let displayOrder: Int?
            let uniquId: String?
        }

        struct Response {
            let responseModel: ProductListResponseModel?
        }

        struct ViewModel {
            let productCount: Int
            let hasSelectedFilters: Bool
            let data: [FilterItemCellViewModel]
        }
    }
}
