//
//  UIViewControllerExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            T(nibName: String(describing: self), bundle: nil)
        }

        return instanceFromNib()
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
