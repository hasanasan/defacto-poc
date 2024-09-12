//
//  UIFontExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - MulishFontType -

enum MulishFontType: String {
    case extraLight = "Mulish-ExtraLight"
    case light = "Mulish-Light"
    case regular = "Mulish-Regular"
    case medium = "Mulish-Medium"
    case semiBold = "Mulish-SemiBold"
    case bold = "Mulish-Bold"
    case extraBold = "Mulish-ExtraBold"
    case black = "Mulish-Black"
    case extraLightItalic = "Mulish-ExtraLightItalic"
    case lightItalic = "Mulish-LightItalic"
    case italic = "Mulish-Italic"
    case mediumItalic = "Mulish-MediumItalic"
    case semiBoldItalic = "Mulish-SemiBoldItalic"
    case boldItalic = "Mulish-BoldItalic"
    case extraBoldItalic = "Mulish-ExtraBoldItalic"
    case blackItalic = "Mulish-BlackItalic"
}

// MARK: - FontFamily -

enum FontFamily {
    case mulish(MulishFontType)
}

extension UIFont {
    static func customFont(fontFamily: FontFamily, size: CGFloat) -> UIFont {
        switch fontFamily {
        case .mulish(let mulishFontType):
            return UIFont(name: mulishFontType.rawValue, size: size) ?? .systemFont(ofSize: size)
        }
    }
}
