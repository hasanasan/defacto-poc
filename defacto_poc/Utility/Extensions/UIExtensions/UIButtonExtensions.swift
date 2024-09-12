//
//  UIButtonExtensions.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

extension UIButton {
    func setTitleAttributes(font: UIFont, color: UIColor, state: UIControl.State) {
        if #available(iOS 15.0, *) {
            var config = configuration ?? UIButton.Configuration.plain()

            config.titleTextAttributesTransformer =
                UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = font
                    outgoing.foregroundColor = color
                    return outgoing
                }

            configuration = config
        } else {
            setTitleColor(color, for: state)
            titleLabel?.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 14)
        }
    }

    func setImageInsets(padding: CGFloat, insets: UIEdgeInsets) {
        if #available(iOS 15.0, *) {
            var config = configuration ?? UIButton.Configuration.plain()
            config.imagePadding = padding

            configuration = config
        } else {
            imageEdgeInsets = insets
        }
    }

    func setContentInsets(insets: UIEdgeInsets) {
        if #available(iOS 15.0, *) {
            var config = configuration ?? UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: insets.top,
                                                           leading: insets.left,
                                                           bottom: insets.bottom,
                                                           trailing: insets.right)
            configuration = config
        } else {
            imageEdgeInsets = insets
        }
    }
}
