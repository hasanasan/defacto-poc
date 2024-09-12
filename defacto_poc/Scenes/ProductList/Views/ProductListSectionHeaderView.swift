//
//  ProductListSectionHeaderView.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - ProductListSectionHeaderViewModel -

struct ProductListSectionHeaderViewModel: Hashable {
    let id: String
    let productCount: Int?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - ProductListSectionHeaderViewDelegate -

protocol ProductListSectionHeaderViewDelegate: AnyObject {
    func didTapChangeDisplayType(_ view: ProductListSectionHeaderView, isGridView: Bool)
    func didTapChangeSorting(_ view: ProductListSectionHeaderView)
    func didTapChangeFilters(_ view: ProductListSectionHeaderView)
}

// MARK: - ProductListSectionHeaderView -

class ProductListSectionHeaderView: UICollectionReusableView {
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

    weak var delegate: ProductListSectionHeaderViewDelegate?

    func configure(viewModel: ProductListSectionHeaderViewModel) {
        titleLabel.text = "\(viewModel.productCount ?? 0) ürün gösteriliyor"
    }

    // MARK: - Private -

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()

    private lazy var displayTypeButton: UIButton = {
        let view = UIButton()
        view.setImage(.icDisplayBlock, for: .normal)
        view.setImage(.icDisplayBlock, for: .selected)
        view.setTitle("Görünüm", for: .normal)

        let font = UIFont.customFont(fontFamily: .mulish(.light), size: 15)
        view.setTitleAttributes(font: font, color: .color22242A, state: .normal)
        view.setImageInsets(padding: 5, insets: .init(top: 0, left: 5, bottom: 0, right: 0))
        view.setContentInsets(insets: .zero)
        if #available(iOS 15.0, *) {
            view.configuration?.baseBackgroundColor = .clear
        }
        view.addTarget(self, action: #selector(self.displayTypeAction), for: .touchUpInside)
        return view
    }()

    private lazy var sortButton: UIButton = {
        let view = UIButton()
        view.setImage(.icSort, for: .normal)
        view.setTitle("Sırala", for: .normal)

        let font = UIFont.customFont(fontFamily: .mulish(.light), size: 15)
        view.setTitleAttributes(font: font, color: .color22242A, state: .normal)
        view.setImageInsets(padding: 5, insets: .init(top: 0, left: 5, bottom: 0, right: 0))
        view.setContentInsets(insets: .zero)
        view.addTarget(self, action: #selector(self.sortingAction), for: .touchUpInside)
        return view
    }()

    private lazy var filterButton: UIButton = {
        let view = UIButton()
        view.setImage(.icFilter, for: .normal)
        view.setTitle("Filtrele", for: .normal)

        let font = UIFont.customFont(fontFamily: .mulish(.light), size: 15)
        view.setTitleAttributes(font: font, color: .color22242A, state: .normal)
        view.setImageInsets(padding: 5, insets: .init(top: 0, left: 5, bottom: 0, right: 0))
        view.setContentInsets(insets: .zero)
        view.addTarget(self, action: #selector(self.filterAction), for: .touchUpInside)
        return view
    }()

    private lazy var firstVerticalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorA6A7AB
        return view
    }()

    private lazy var secondVerticalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorA6A7AB
        return view
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [displayTypeButton,
                                                       firstVerticalSeparatorView,
                                                       sortButton,
                                                       secondVerticalSeparatorView,
                                                       filterButton])
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 13)
        label.textColor = .color4C4C58
        return label
    }()

    private func commonInit() {
        addSubview(containerStackView)

        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }

        sortButton.snp.makeConstraints {
            $0.width.equalTo(displayTypeButton)
        }

        filterButton.snp.makeConstraints {
            $0.width.equalTo(sortButton)
        }

        firstVerticalSeparatorView.snp.makeConstraints {
            $0.width.equalTo(1)
        }

        secondVerticalSeparatorView.snp.makeConstraints {
            $0.width.equalTo(1)
        }
    }

    @objc
    private func displayTypeAction() {
        delegate?.didTapChangeDisplayType(self, isGridView: displayTypeButton.isSelected)

        displayTypeButton.isSelected.toggle()
    }

    @objc
    private func sortingAction() {
        delegate?.didTapChangeSorting(self)
    }

    @objc
    private func filterAction() {
        delegate?.didTapChangeFilters(self)
    }
}
