//
//  FilterItemCell.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - FilterItemCell -

class FilterItemCell: UITableViewCell {
    // MARK: - Lifecycle -

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Internal -

    func configure(viewModel: FilterItemCellViewModel) {
        titleLabel.text = viewModel.title
    }

    // MARK: - Private -

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 13)
        label.textColor = .color4C4C58
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()

    private func commonInit() {
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)

        iconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(20)
        }
    }
}

// MARK: - FilterItemCellViewModel -

struct FilterItemCellViewModel {
    let id: String?
    let title: String?
    let isSelected: Bool
    let displayOrder: Int?
    let uniquId: String?
}
