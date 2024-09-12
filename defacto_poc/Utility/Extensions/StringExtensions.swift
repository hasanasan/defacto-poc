//
//  StringExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

extension String {
    static var empty: Self {
        ""
    }

    var localized: String {
        NSLocalizedString(self, comment: "") // swiftlint:disable:this nslocalizedstring_key
    }

    func strikethrough(font: UIFont) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.strikethroughStyle: 1,
                                                    .font: font]

        let attributeString = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attributeString.length)
        attributeString.addAttributes(attrs, range: range)
        return attributeString
    }

    func toInt() -> Int? {
        Int(self)
    }

    func toDouble() -> Double? {
        Double(self)
    }
}
