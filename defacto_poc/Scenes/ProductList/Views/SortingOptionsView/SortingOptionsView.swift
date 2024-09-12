//
//  SortingOptionsView.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import UIKit

// MARK: - SortingOptionsView -

final class SortingOptionsView: UIView {
    // MARK: - Lifecycle -

    init() {
        super.init(frame: .zero)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Internal -

    var selectionCallback: ((_ id: String) -> Void)?

    func display(on parentView: UIView, sortingOptions: [SortingOptionItemCellViewModel]) {
        parentView.addSubview(self)

        snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        data = sortingOptions
        tableView.reloadData()

        innerContainerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)

        UIView.animate(withDuration: 0.3) {
            self.innerContainerView.transform = .identity
            self.innerContainerView.alpha = 1
            self.containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }

    func dismiss() {
        UIView.animate(withDuration: 0.3) {
            self.innerContainerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            self.innerContainerView.alpha = 0
            self.containerView.backgroundColor = .clear
        } completion: { isFinished in
            if isFinished {
                self.removeFromSuperview()
            }
        }
    }

    // MARK: - Private -

    private var data: [SortingOptionItemCellViewModel] = []

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var innerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Sırala"
        view.textColor = .color22242A
        view.font = UIFont.customFont(fontFamily: .mulish(.regular), size: 20)
        return view
    }()

    private lazy var tableView: IntrinsicTableView = {
        let view = IntrinsicTableView(frame: .zero, style: .plain)
        view.registerCell(with: SortingOptionItemCell.self)
        view.dataSource = self
        view.delegate = self
        view.separatorInset = .init(top: 0, left: 12, bottom: 0, right: 0)
        return view
    }()

    private lazy var dismissButton: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return view
    }()

    private func commonInit() {
        addSubview(containerView)
        containerView.addSubview(innerContainerView)
        innerContainerView.addSubview(titleLabel)
        innerContainerView.addSubview(dismissButton)
        innerContainerView.addSubview(tableView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        innerContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(20)
        }

        dismissButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }

        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    @objc
    private func dismissAction() {
        dismiss()
    }
}

// MARK: - UITableViewDataSource -

extension SortingOptionsView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(withClass: SortingOptionItemCell.self)
        let item = data[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
}

// MARK: - UITableViewDelegate -

extension SortingOptionsView: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]

        if let id = item.id {
            selectionCallback?(id)
        }
    }
}
