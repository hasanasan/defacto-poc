//
//  FilterDetailViewController.swift
//  defacto-poc
//
//  Copyright (c) 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - FilterDetailViewControllerDelegate -

protocol FilterDetailViewControllerDelegate: AnyObject {
    func didApplyFilters(_ controller: FilterDetailViewController?, filterModel: F?)
}

// MARK: - FilterDetailDisplayLogic -

protocol FilterDetailDisplayLogic: AnyObject {
    func displayFilterDetailList(viewModel: FilterDetail.List.ViewModel)
}

// MARK: - FilterDetailViewController -

final class FilterDetailViewController: UIViewController {
    // MARK: - Lifecycle -

    init(worker: FilterDetailWorkProtocol) {
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

    var interactor: FilterDetailBusinessLogic?
    var router: (NSObjectProtocol & FilterDetailRoutingLogic & FilterDetailDataPassing)?

    weak var delegate: FilterDetailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViews()

        interactor?.viewDidLoad()
    }

    // MARK: - Private -

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.registerCell(with: FilterDetailItemCell.self)
        view.dataSource = self
        view.delegate = self
        view.separatorInset = .zero
        return view
    }()

    private lazy var applyButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitle("Uygula", for: .normal)

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

    private var data: [FilterDetailItemCellViewModel] = []

    private func setup(worker: FilterDetailWorkProtocol = FilterDetailWorker()) {
        let viewController = self
        let interactor = FilterDetailInteractor(worker: worker)
        let presenter = FilterDetailPresenter()
        let router = FilterDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func prepareViews() {
        view.backgroundColor = .white

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
    private func clearAction() {
        interactor?.didTapClear()
    }

    @objc
    private func applyAction() {
        router?.navigate(to: .popToParent)
    }
}

// MARK: - FilterDetailDisplayLogic -

extension FilterDetailViewController: FilterDetailDisplayLogic {
    func displayFilterDetailList(viewModel: FilterDetail.List.ViewModel) {
        data = viewModel.data
        clearBarButtonItem.isEnabled = viewModel.hasSelectedFilters
        navigationItem.title = viewModel.pageTitle

        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource -

extension FilterDetailViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(withClass: FilterDetailItemCell.self)
        let item = data[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
}

// MARK: - UITableViewDelegate -

extension FilterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = data[indexPath.row].id {
            let isSelected = data[indexPath.row].isSelected
            data[indexPath.row].isSelected = !isSelected

            let request = FilterDetail.List.Request(filterId: id, isSelected: !isSelected)
            interactor?.didUpdateFilter(request: request)

            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
