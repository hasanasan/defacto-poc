//
//  SortingOptionItemCell.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - SortingOptionItemCell -

final class SortingOptionItemCell: UITableViewCell {
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

    func configure(viewModel: SortingOptionItemCellViewModel) {
        titleLabel.text = viewModel.title
        iconButton.isSelected = viewModel.isSelected
    }

    // MARK: - Private -

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 13)
        label.textColor = .color4C4C58
        return label
    }()

    private lazy var iconButton: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        view.isUserInteractionEnabled = false
        view.setImage(UIImage(systemName: "square"), for: .normal)
        view.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        return view
    }()

    private func commonInit() {
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        contentView.addSubview(iconButton)

        iconButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalTo(iconButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
}

// MARK: - SortingOptionItemCellViewModel -

struct SortingOptionItemCellViewModel {
    let id: String?
    let title: String?
    var isSelected: Bool
}
