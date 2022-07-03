//
//  DateSelectionController.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/06/01.
//

import UIKit

class DateSelectionController: UIViewController {

    // MARK: - Properties

    var asset: Asset
    var timeSeriesMonthlyAdjusted: TimeSeriesMonthlyAdjusted
    var selectedIndex: Int?
<<<<<<< HEAD

=======
    
>>>>>>> develop
    private var monthInfos: [MonthInfo] = []
    var didSelectDate: ((Int) -> Void)?

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = 64
        $0.delegate = self
        $0.dataSource = self
        $0.register(DateSelectionCell.self, forCellReuseIdentifier: DateSelectionCell.identifier)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        setupMonthInfos()
        setupNavigationBar(title: "날짜 선택", largeTitles: false)
    }

    init(asset: Asset, timeSeriesMonthlyAdjusted: TimeSeriesMonthlyAdjusted) {
        self.asset = asset
        self.timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted
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

    private func setupMonthInfos() {
        self.monthInfos = timeSeriesMonthlyAdjusted.getMonthInfos()
    }
}

extension DateSelectionController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateSelectionCell.identifier, for: indexPath) as? DateSelectionCell ?? DateSelectionCell()
        let index = indexPath.item
        let isSelected = index == selectedIndex
        let monthInfo = monthInfos[index]
<<<<<<< HEAD
        let isSelected = index == selectedIndex
=======
>>>>>>> develop
        cell.configure(with: monthInfo, index: index, isSelected: isSelected)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectDate?(indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
