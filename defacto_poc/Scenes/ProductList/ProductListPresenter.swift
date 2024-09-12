//
//  ProductListPresenter.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - ProductListPresentationLogic -

protocol ProductListPresentationLogic: AnyObject {
    func presentProductList(response: ProductList.List.Response)
    func presentAppendProducts(response: ProductList.Append.Response)
}

// MARK: - ProductListPresenter -

final class ProductListPresenter {
    weak var viewController: ProductListDisplayLogic?
}

// MARK: - ProductListPresentationLogic -

extension ProductListPresenter: ProductListPresentationLogic {
    // MARK: - Internal -

    func presentProductList(response: ProductList.List.Response) {
        var sections: [ProductListSection: [ProductListItem]] = [:]
        var sectionHeaders: [ProductListSection: AnyHashable] = [:]

        // add category data
        if let categories = response.responseModel?.getCategories() {
            let categoryData = categories.map { item in
                let viewModel = CategoryItemCellViewModel(uniqueId: UUID().uuidString,
                                                          id: item.i,
                                                          title: item.t,
                                                          isSelected: item.s ?? false)
                return ProductList.List.ViewModel.Item.categoryItem(viewModel: viewModel)
            }

            sections[.categories] = categoryData
        }

        // add product data
        if let products = response.responseModel?.getProducts() {
            let productData = getProductListItems(source: products)
            sections[.products] = productData

            let headerModel = ProductListSectionHeaderViewModel(id: UUID().uuidString, productCount: response.responseModel?.d?.c)
            sectionHeaders[.products] = headerModel
        }

        // prepare sorting options
        let sortingOptions = response.responseModel?.getSortingOptions()?.map { item in
            SortingOptionItemCellViewModel(id: item.v,
                                           title: item.k,
                                           isSelected: item.v == response.selectedSortingOptionId)
        } ?? []

        let viewModel = ProductList.List.ViewModel(sections: sections,
                                                   sortingOptions: sortingOptions,
                                                   sectionHeaders: sectionHeaders)
        viewController?.displayProductList(viewModel: viewModel)
    }

    func presentAppendProducts(response: ProductList.Append.Response) {
        if let products = response.responseModel?.getProducts() {
            let productData = getProductListItems(source: products)
            let viewModel = ProductList.Append.ViewModel(data: productData)
            viewController?.displayAppendProducts(viewModel: viewModel)
        }
    }

    // MARK: - Private -

    private func getProductListItems(source: [Doc]) -> [ProductListItem] {
        let productData = source.map { item in
            var colorVariantCount: String?
            if let pcc = item.pcc, pcc != 0 {
                colorVariantCount = "+\(pcc)"
            }

            var reviewCount: String?
            if let count = item.trc?.toInt().toString() {
                reviewCount = "(\(count))"
            }
            let viewModel = ProductItemCellViewModel(uniqueId: UUID().uuidString,
                                                     id: item.pid,
                                                     name: item.pname,
                                                     price: item.ppt?.toString(),
                                                     discountedPrice: item.pvcdpt?.isEmpty == true ? nil : item.pvcdpt,
                                                     campaignText: item.pvcbd,
                                                     rating: item.ar,
                                                     reviewCount: reviewCount,
                                                     colorVariantCount: colorVariantCount,
                                                     images: item.getProductImageURLData() ?? [])
            return ProductList.List.ViewModel.Item.productItem(viewModel: viewModel)
        }

        return productData
    }
}
