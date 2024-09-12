//
//  UICollectionViewExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell(with classType: AnyClass) {
        register(classType, forCellWithReuseIdentifier: String(describing: classType.self))
    }

    func dequeue<T>(withClass _: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(String(describing: T.self)) from collectionView \(self)")
        }
        return cell
    }

    func dequeue<T: UICollectionViewCell>(withIdentifier identifier: String = String(describing: T.self),
                                          for indexPath: IndexPath)
        -> T
    {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(identifier) from collectionView \(self)")
        }
        return cell
    }

    func registerSupplementaryView(with viewClass: AnyClass, elementKind: String) {
        register(viewClass,
                 forSupplementaryViewOfKind: elementKind,
                 withReuseIdentifier: String(describing: viewClass.self))
    }

    func dequeueSupplementaryView<T>(with _: T.Type,
                                     kind: String,
                                     for indexPath: IndexPath)
        -> T?
    {
        dequeueReusableSupplementaryView(ofKind: kind,
                                         withReuseIdentifier: String(describing: T.self),
                                         for: indexPath) as? T
    }
}

extension UICollectionViewDiffableDataSource {
    func reloadData(snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>,
                    animated: Bool = false,
                    completion: (() -> Void)? = nil)
    {
        if #available(iOS 15.0, *) {
            self.applySnapshotUsingReloadData(snapshot, completion: completion)
        } else {
            apply(snapshot, animatingDifferences: animated, completion: completion)
        }
    }

    func applySnapshot(_ snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>,
                       animated: Bool,
                       completion: (() -> Void)? = nil)
    {
        if #available(iOS 15.0, *) {
            self.apply(snapshot, animatingDifferences: animated, completion: completion)
        } else {
            if animated {
                apply(snapshot, animatingDifferences: true, completion: completion)
            } else {
                UIView.performWithoutAnimation {
                    self.apply(snapshot, animatingDifferences: true, completion: completion)
                }
            }
        }
    }
}
