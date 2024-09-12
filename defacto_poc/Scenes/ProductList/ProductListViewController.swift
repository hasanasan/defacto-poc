//
//  ProductListViewController.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import SnapKit
import UIKit

// MARK: - ProductListDisplayLogic -

protocol ProductListDisplayLogic: AnyObject {
    func displayProductList(viewModel: ProductList.List.ViewModel)
    func displayAppendProducts(viewModel: ProductList.Append.ViewModel)
}

// MARK: - ProductListViewController -

final class ProductListViewController: UIViewController {
    // MARK: - Lifecycle -

    init(worker: ProductListWorkProtocol) {
        super.init(nibName: nil, bundle: nil)
        setup(worker: worker)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Internal -

    typealias ProductListDiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<ProductListSection, ProductListItem>
    typealias ProductListDiffableDataSource = UICollectionViewDiffableDataSource<ProductListSection, ProductListItem>

    var interactor: ProductListBusinessLogic?
    var router: (NSObjectProtocol & ProductListRoutingLogic & ProductListDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViews()

        configureDataSource()

        configureLayout()

        interactor?.viewDidLoad()
    }

    // MARK: - Private -

    private var dataSource: ProductListDiffableDataSource?
    private var viewModel: ProductList.List.ViewModel?
    private var isGridView = true

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(with: CategoryItemCell.self)
        collectionView.registerCell(with: ProductItemCell.self)
        collectionView.registerSupplementaryView(with: ProductListSectionHeaderView.self,
                                                 elementKind: ProductListElementKind.productListHeaderElementKind)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .zero
        collectionView.delegate = self
        return collectionView
    }()

    private func setup(worker: ProductListWorkProtocol = ProductListWorker()) {
        let viewController = self
        let interactor = ProductListInteractor(worker: worker)
        let presenter = ProductListPresenter()
        let router = ProductListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func prepareViews() {
        navigationItem.title = "Defacto"
        view.backgroundColor = .white

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }

    private func configureDataSource() {
        dataSource = ProductListDiffableDataSource(collectionView: collectionView,
                                                   cellProvider: { [weak self] collectionView, indexPath, item in
                                                       self?.cell(collectionView: collectionView, indexPath: indexPath,
                                                                  item: item)
                                                   })

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
    }

    private func configureLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak dataSource] sectionIndex, _ in
            let section = dataSource?.snapshot().sectionIdentifiers[sectionIndex]
            switch section {
            case .categories:
                return ProductListLayoutFactory.layoutForCategories()
            case .products:
                return ProductListLayoutFactory.layoutForProducts(isGridView: self.isGridView)
            case .none:
                return nil
            }
        }

        collectionView.setCollectionViewLayout(layout, animated: false)
    }

    private func makeSnapshotForViewModel(_ viewModel: ProductList.List.ViewModel) -> ProductListDiffableDataSourceSnapshot {
        var snapshot = ProductListDiffableDataSourceSnapshot()
        viewModel.sections
            .sorted { $0.key.order < $1.key.order }
            .forEach { section, items in
                snapshot.appendSections([section])
                snapshot.appendItems(items, toSection: section)
            }

        return snapshot
    }

    private func applySnapshot() {
        guard let viewModel else {
            return
        }

        let snapshot = makeSnapshotForViewModel(viewModel)

        DispatchQueue.main.async {
            self.dataSource?.reloadData(snapshot: snapshot, animated: true, completion: nil)
        }
    }

    private func cell(collectionView: UICollectionView,
                      indexPath: IndexPath,
                      item: ProductList.List.ViewModel.Item)
        -> UICollectionViewCell
    {
        switch item {
        case .categoryItem(let viewModel):
            let cell = collectionView.dequeue(withClass: CategoryItemCell.self, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case .productItem(let viewModel):
            let cell = collectionView.dequeue(withClass: ProductItemCell.self, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }

    private func supplementary(collectionView: UICollectionView,
                               kind: String,
                               indexPath: IndexPath)
        -> UICollectionReusableView?
    {
        switch kind {
        case ProductListElementKind.productListHeaderElementKind:
            let headerView: ProductListSectionHeaderView? =
                collectionView.dequeueSupplementaryView(with: ProductListSectionHeaderView.self,
                                                        kind: kind,
                                                        for: indexPath)

            if let viewModel = viewModel?.sectionHeaders[.products] as? ProductListSectionHeaderViewModel {
                headerView?.configure(viewModel: viewModel)
                headerView?.delegate = self
            }

            return headerView
        default:
            return nil
        }
    }

    private func displaySortingOptions() {
        let sortingOptionsView = SortingOptionsView()
        sortingOptionsView.selectionCallback = { [weak self] id in
            let request = ProductList.Sort.Request(selectedId: id)
            self?.interactor?.didChangeSorting(request: request)

            sortingOptionsView.dismiss()
        }

        sortingOptionsView.display(on: view, sortingOptions: viewModel?.sortingOptions ?? [])
    }
}

// MARK: - ProductListDisplayLogic -

extension ProductListViewController: ProductListDisplayLogic {
    func displayProductList(viewModel: ProductList.List.ViewModel) {
        self.viewModel = viewModel

        applySnapshot()
    }

    func displayAppendProducts(viewModel: ProductList.Append.ViewModel) {
        if var snapshot = dataSource?.snapshot() {
            snapshot.appendItems(viewModel.data, toSection: .products)
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - ProductListSectionHeaderViewDelegate -

extension ProductListViewController: ProductListSectionHeaderViewDelegate {
    func didTapChangeDisplayType(_: ProductListSectionHeaderView, isGridView: Bool) {
        self.isGridView = isGridView

        configureLayout()
    }

    func didTapChangeSorting(_: ProductListSectionHeaderView) {
        displaySortingOptions()
    }

    func didTapChangeFilters(_: ProductListSectionHeaderView) {
        router?.navigate(to: .filterList)
    }
}

// MARK: - UICollectionViewDelegate -

extension ProductListViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)

        if isReachingEnd == true {
            interactor?.loadMore()
        }
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }

        switch item {
        case .categoryItem(let viewModel):
            if let id = viewModel.id {
                let request = ProductList.List.Request(categoryId: id)
                interactor?.didSelectCategory(request: request)
            }
        default:
            break
        }
    }
}
