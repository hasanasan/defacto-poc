//
//  UITableViewExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell(with classType: AnyClass) {
        register(classType, forCellReuseIdentifier: String(describing: classType.self))
    }

    func dequeue<T: UITableViewCell>(withIdentifier identifier: String = String(describing: T.self)) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T
        else {
            fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)")
        }
        return cell
    }

    func dequeue<T: UITableViewCell>(withClass _: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
        else {
            fatalError("Could not dequeue cell with identifier \(String(describing: T.self)) from tableView \(self)")
        }
        return cell
    }

    func dequeue<T: UITableViewCell>(withClass _: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier \(String(describing: T.self)) from tableView \(self)")
        }
        return cell
    }

    func dequeue<T: UITableViewCell>(withIdentifier identifier: String = String(describing: T.self),
                                     at indexPath: IndexPath)
        -> T
    {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)")
        }
        return cell
    }

    func registerHeaderFooterView(with aClass: AnyClass) {
        register(aClass, forHeaderFooterViewReuseIdentifier: String(describing: aClass.self))
    }

    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(with classType: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: classType.self)) as? T else {
            fatalError("Could not dequeue header/footer view with identifier \(String(describing: classType.self)) from tableView \(self)")
        }

        return view
    }

    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String = String(describing: T.self))
        -> T
    {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)")
        }
        return cell
    }
}
