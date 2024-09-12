//
//  ProductListLayoutFactory.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - ProductListElementKind -

enum ProductListElementKind {
    static let productListHeaderElementKind = "ProductListHeaderElementKind"
}

// MARK: - ProductListLayoutFactory -

enum ProductListLayoutFactory {
    static func layoutForCategories() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                               heightDimension: .absolute(40))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        return section
    }

    static func layoutForProducts(isGridView: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(isGridView ? 0.5 : 1),
                                              heightDimension: .estimated(200))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: isGridView ? 2 : 1)
        group.interItemSpacing = .fixed(2)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        let sectionHeader =
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                           heightDimension: .estimated(50)),
                                                        elementKind: ProductListElementKind
                                                            .productListHeaderElementKind,
                                                        alignment: .topLeading)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
}
