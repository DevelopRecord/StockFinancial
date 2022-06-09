//
//  CalculatorViewController.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/30.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: - Properties

    var asset: Asset
    var selectedDateString: String?

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.register(CalculatorViewCell.self, forCellReuseIdentifier: CalculatorViewCell.identifier)
        $0.register(CalcaulatorViewSecondCell.self, forCellReuseIdentifier: CalcaulatorViewSecondCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(title: "", largeTitles: false)
    }

    init(asset: Asset) {
        self.asset = asset
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
    }

    private func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func handleDateSelection(at index: Int) {
        guard navigationController?.visibleViewController is DateSelectionController else { return }
        navigationController?.popViewController(animated: true)
        let monthInfos = asset.timeSeriesMonthlyAdjusted.getMonthInfos()
        let monthInfo = monthInfos[index]
        print("monthInfo ||||| \(monthInfo) | \(index)")
        let dateString = monthInfo.date.YYMMFormat
        self.selectedDateString = dateString
        self.tableView.reloadData()
    }
}

extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorViewCell.identifier, for: indexPath) as? CalculatorViewCell ?? CalculatorViewCell()
            cell.configure(symbol: asset.searchResult.symbol, type: asset.searchResult.type, currency: asset.searchResult.currency)
            return cell
        } else if indexPath.row == 1 {
            let secondCell = tableView.dequeueReusableCell(withIdentifier: CalcaulatorViewSecondCell.identifier, for: indexPath) as? CalcaulatorViewSecondCell ?? CalcaulatorViewSecondCell()
            secondCell.configure(currency: asset.searchResult.currency)
            secondCell.initialDateOfInvestmentTextField.text = selectedDateString
            secondCell.delegate = self
            return secondCell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else if indexPath.row == 1 {
            return 230
        } else {
            return 150
        }
    }
}

extension CalculatorViewController: CalcaulatorViewSecondCellDelegate {
    func pushViewController() {
        let controller = DateSelectionController(asset: asset, timeSeriesMonthlyAdjusted: asset.timeSeriesMonthlyAdjusted)
        controller.didSelectDate = { [weak self] index in
            print("인덱스 정보: \(index)")
            self?.handleDateSelection(at: index)
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
