//
//  FilterListViewController.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - FilterListViewControllerDelegate -

protocol FilterListViewControllerDelegate: AnyObject {
    func didApplyFilters(_ controller: FilterListViewController?, responseModel: ProductListResponseModel?)
}

// MARK: - FilterListDisplayLogic -

protocol FilterListDisplayLogic: AnyObject {
    func displayFilterList(viewModel: FilterList.List.ViewModel)
    func displayFilterDetails()
}

// MARK: - FilterListViewController -

final class FilterListViewController: UIViewController {
    // MARK: - Lifecycle -

    init(worker: FilterListWorkProtocol) {
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

    var interactor: FilterListBusinessLogic?
    var router: (NSObjectProtocol & FilterListRoutingLogic & FilterListDataPassing)?

    weak var delegate: FilterListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViews()

        interactor?.viewDidLoad()
    }

    // MARK: - Private -

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.registerCell(with: FilterItemCell.self)
        view.dataSource = self
        view.delegate = self
        view.separatorInset = .zero
        return view
    }()

    private lazy var applyButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .black

        let font = UIFont.customFont(fontFamily: .mulish(.light), size: 15)
        view.setTitleAttributes(font: font, color: .white, state: .normal)
        view.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
        return view
    }()

    private lazy var clearBarButtonItem: UIBarButtonItem = {
        let clearButton = UIBarButtonItem(title: "Temizle",
                                          style: .plain,
                                          target: self,
                                          action: #selector(clearAction))
        navigationItem.rightBarButtonItem = clearButton
        return clearButton
    }()

    private var data: [FilterItemCellViewModel] = []

    private func setup(worker: FilterListWorkProtocol = FilterListWorker()) {
        let viewController = self
        let interactor = FilterListInteractor(worker: worker)
        let presenter = FilterListPresenter()
        let router = FilterListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func prepareViews() {
        navigationItem.backButtonTitle = ""
        navigationItem.title = "Filtrele ve Sırala"
        view.backgroundColor = .white

        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(closeAction))
        navigationItem.leftBarButtonItem = closeButton

        view.addSubview(tableView)
        view.addSubview(applyButton)

        tableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
        }

        applyButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(tableView.snp.bottom).offset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.height.equalTo(40)
        }
    }

    @objc
    private func closeAction() {
        navigationController?.dismiss(animated: true)
    }

    @objc
    private func clearAction() {
        interactor?.didTapClear()
    }

    @objc
    private func applyAction() {
        router?.navigate(to: .productList(delegate: delegate))
    }
}

// MARK: - FilterListDisplayLogic -

extension FilterListViewController: FilterListDisplayLogic {
    func displayFilterList(viewModel: FilterList.List.ViewModel) {
        data = viewModel.data
        clearBarButtonItem.isEnabled = viewModel.hasSelectedFilters
        applyButton.setTitle("\(viewModel.productCount) Ürünü Gör", for: .normal)
        tableView.reloadData()
    }

    func displayFilterDetails() {
        router?.navigate(to: .filterDetail)
    }
}

// MARK: - UITableViewDataSource -

extension FilterListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(withClass: FilterItemCell.self)
        let item = data[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
}

// MARK: - UITableViewDelegate -

extension FilterListViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        let request = FilterList.List.Request(id: item.id, displayOrder: item.displayOrder, uniquId: item.uniquId)
        interactor?.didSelectFilter(request: request)
    }
}
