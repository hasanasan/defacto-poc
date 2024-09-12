//
//  ProductImageItemCell.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import Kingfisher
import UIKit

class ProductImageItemCell: UICollectionViewCell {
    // MARK: - Lifecycle -

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Internal -

    func configure(url: URL) {
        productImageView.kf.setImage(with: url)
    }

    // MARK: - Private -

    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private func commonInit() {
        contentView.addSubview(productImageView)

        productImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
