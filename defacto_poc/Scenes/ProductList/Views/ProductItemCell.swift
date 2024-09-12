//
//  ProductItemCell.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import CHIPageControl
import Cosmos
import UIKit

// MARK: - ProductItemCell -

final class ProductItemCell: UICollectionViewCell {
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

    func configure(viewModel: ProductItemCellViewModel) {
        titleLabel.text = viewModel.name
        ratingView.rating = viewModel.rating ?? 0
        reviewCountLabel.text = viewModel.reviewCount
        colorVariantLabel.text = viewModel.colorVariantCount
        colorVariantContainerView.isHidden = viewModel.colorVariantCount == nil

        priceLabel.text = nil
        priceLabel.attributedText = nil

        if let discountedPrice = viewModel.discountedPrice {
            priceLabel.attributedText = (viewModel.price ?? "")
                .strikethrough(font: UIFont.customFont(fontFamily: .mulish(.regular), size: 15))
            discountedPriceLabel.text = discountedPrice
            discountedPriceLabel.isHidden = false
            campaignTitleLabel.isHidden = false
            campaignTitleLabel.text = viewModel.campaignText
        } else {
            priceLabel.text = viewModel.price
            discountedPriceLabel.isHidden = true
            campaignTitleLabel.isHidden = true
        }

        imageData = viewModel.images
        pageControl.numberOfPages = imageData.count

        setNeedsLayout()
        layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageCollectionView.reloadData()
        imageCollectionView.setContentOffset(.zero, animated: false)

        if imageData.isEmpty == false {
            let pageControlWidth = frame.size.width - 16
            let pageWidthSize = (pageControlWidth - CGFloat(imageData.count * 5)) / CGFloat(imageData.count)
            pageControl.elementWidth = pageWidthSize
            pageControl.set(progress: 0, animated: false)
        }
    }

    // MARK: - Private -

    private lazy var topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var pageControl: CHIPageControlJaloro = {
        let view = CHIPageControlJaloro()
        view.radius = 0
        view.tintColor = .color575562
        view.currentPageTintColor = .white
        view.padding = 5
        view.hidesForSinglePage = true
        view.elementHeight = 3
        return view
    }()

    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.registerCell(with: ProductImageItemCell.self)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var textStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, metaContainerView, priceLabel, campaignTitleLabel,
                                                  discountedPriceLabel])
        view.axis = .vertical
        view.spacing = 4
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = .color22242A
        view.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 15)
        return view
    }()

    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .color22242A
        view.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 15)
        return view
    }()

    private lazy var campaignTitleLabel: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.textColor = .colorB71B1B
        view.font = UIFont.customFont(fontFamily: .mulish(.bold), size: 13)
        view.text = "Sepet Tutarı"
        return view
    }()

    private lazy var discountedPriceLabel: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.textColor = .colorB71B1B
        view.font = UIFont.customFont(fontFamily: .mulish(.bold), size: 15)
        return view
    }()

    private lazy var favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(.icFavorite, for: .normal)
        view.setImage(.icFavoriteFill, for: .selected)
        return view
    }()

    private lazy var addToCartButton: UIButton = {
        let view = UIButton()
        view.setImage(.icAddToCart, for: .normal)
        return view
    }()

    private lazy var metaContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var ratingContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.totalStars = 5
        view.settings.starSize = 12
        view.settings.starMargin = 5
        view.settings.emptyImage = .icStarEmpty
        view.settings.filledImage = .icStarFilled
        view.settings.filledColor = .clear
        view.settings.emptyBorderColor = .clear
        view.settings.filledBorderColor = .clear
        view.settings.fillMode = .precise
        return view
    }()

    private lazy var reviewCountLabel: UILabel = {
        let view = UILabel()
        view.textColor = .color22242A
        view.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 13)
        return view
    }()

    private lazy var colorVariantContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.06).cgColor
        return view
    }()

    private lazy var colorVariantIconView: UIImageView = {
        let view = UIImageView(image: .icColorPalette)
        return view
    }()

    private lazy var colorVariantLabel: UILabel = {
        let view = UILabel()
        view.textColor = .color22242A
        view.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 12)
        return view
    }()

    private var imageData: [URL] = []

    private func commonInit() {
        backgroundColor = .clear

        contentView.addSubview(topContainerView)
        contentView.addSubview(textStackView)

        topContainerView.addSubview(imageCollectionView)
        topContainerView.addSubview(favoriteButton)
        topContainerView.addSubview(addToCartButton)
        topContainerView.addSubview(pageControl)

        ratingContainerView.addSubview(ratingView)
        ratingContainerView.addSubview(reviewCountLabel)

        colorVariantContainerView.addSubview(colorVariantLabel)
        colorVariantContainerView.addSubview(colorVariantIconView)

        metaContainerView.addSubview(ratingContainerView)
        metaContainerView.addSubview(colorVariantContainerView)

        topContainerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(topContainerView.snp.width).multipliedBy(1.5)
        }

        imageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        favoriteButton.snp.makeConstraints {
            $0.width.height.equalTo(34)
            $0.top.trailing.equalToSuperview().inset(6)
        }

        addToCartButton.snp.makeConstraints {
            $0.width.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(6)
        }

        pageControl.snp.makeConstraints {
            $0.top.equalTo(addToCartButton.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().offset(-6)
        }

        titleLabel.snp.makeConstraints {
            $0.height.equalTo(38)
        }

        ratingContainerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.leading.equalToSuperview()
        }

        ratingView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }

        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingView.snp.trailing).offset(4)
            $0.centerY.trailing.equalToSuperview()
        }

        colorVariantContainerView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(ratingContainerView.snp.trailing).offset(8)
        }

        colorVariantLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(5)
        }

        colorVariantIconView.snp.makeConstraints {
            $0.width.height.equalTo(14)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalTo(colorVariantLabel.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(5)
        }

        textStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(5)
            make.top.equalTo(topContainerView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-15).priority(.low)
        }
    }
}

// MARK: - UICollectionViewDataSource -

extension ProductItemCell: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        imageData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(withClass: ProductImageItemCell.self, for: indexPath)
        let item = imageData[indexPath.row]
        cell.configure(url: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout -

extension ProductItemCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath)
        -> CGSize
    {
        collectionView.frame.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl.set(progress: pageNumber, animated: true)
    }
}

// MARK: - ProductItemCellViewModel -

struct ProductItemCellViewModel: Hashable {
    let uniqueId: String
    let id: String?
    let name: String?
    let price: String?
    let discountedPrice: String?
    let campaignText: String?
    let rating: Double?
    let reviewCount: String?
    let colorVariantCount: String?
    let images: [URL]

    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueId)
    }
}
