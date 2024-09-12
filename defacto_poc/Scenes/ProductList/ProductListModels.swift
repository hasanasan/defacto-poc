//
//  ProductListModels.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

typealias ProductListSection = ProductList.List.ViewModel.Section
typealias ProductListItem = ProductList.List.ViewModel.Item

// MARK: - ProductList -

enum ProductList {
    enum List {
        struct Request {
            let categoryId: String
        }

        struct Response {
            let responseModel: ProductListResponseModel?
            let selectedSortingOptionId: String?
        }

        struct ViewModel {
            enum Section: Hashable {
                case categories
                case products

                var order: Int {
                    switch self {
                    case .categories:
                        return 0
                    case .products:
                        return 1
                    }
                }
            }

            enum Item: Hashable {
                case categoryItem(viewModel: CategoryItemCellViewModel)
                case productItem(viewModel: ProductItemCellViewModel)
            }

            var sections: [Section: [Item]]
            var sortingOptions: [SortingOptionItemCellViewModel]
            let sectionHeaders: [Section: AnyHashable]
        }
    }

    enum Sort {
        struct Request {
            let selectedId: String
        }

        struct Response { }

        struct ViewModel { }
    }

    enum Append {
        struct Request { }

        struct Response {
            let responseModel: ProductListResponseModel?
        }

        struct ViewModel {
            let data: [ProductListItem]
        }
    }
}
