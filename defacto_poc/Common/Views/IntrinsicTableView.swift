//
//  IntrinsicTableView.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {
    // MARK: - Lifecycle -

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        commonInit()
    }

    // MARK: - Internal -

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    // MARK: - Private -

    private func commonInit() {
        isScrollEnabled = false
        isPagingEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}
