//
//  CategoryItemCell.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import Kingfisher
import UIKit

// MARK: - CategoryItemCell -

class CategoryItemCell: UICollectionViewCell {
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

    func configure(viewModel: CategoryItemCellViewModel) {
        titleLabel.text = viewModel.title

        titleLabel.textColor = viewModel.isSelected ? .white : .color22242A
        contentView.backgroundColor = viewModel.isSelected ? .color575562 : .white
    }

    // MARK: - Private -

    private lazy var containerView: UIView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.color22242A.withAlphaComponent(0.05).cgColor
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 15)
        label.textColor = .color22242A
        label.textAlignment = .center
        return label
    }()

    private func commonInit() {
        backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)

        containerView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
}

// MARK: - CategoryItemCellViewModel -

struct CategoryItemCellViewModel: Hashable {
    let uniqueId: String
    let id: String?
    let title: String?
    let isSelected: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueId)
    }
}
