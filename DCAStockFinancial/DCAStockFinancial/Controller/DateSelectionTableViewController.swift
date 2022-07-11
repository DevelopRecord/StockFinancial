//
//  DateSelectionTableViewController.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/11.
//

import UIKit

class DateSelectionTableViewController: UITableViewController {

    // MARK: - Properties

    var timeSeriesMonthlyAdjusted: TimeSeriesMonthlyAdjusted?
    private var monthInfos: [MonthInfo] = []
    var selectedIndex: Int?
    
    var didSelectDate: ((Int) -> Void)?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonthInfos()
        setupNavigationBar(title: "날짜 선택")
    }

    // MARK: - Helpers

    private func setupMonthInfos() {
        monthInfos = timeSeriesMonthlyAdjusted?.getMonthInfos() ?? []
    }
}

extension DateSelectionTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthInfos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? DateSelectionTableViewCell ?? DateSelectionTableViewCell()
        let index = indexPath.item
        let monthInfo = monthInfos[index]
        let isSelected = index == selectedIndex
        cell.configure(with: monthInfo, index: index, isSelected: isSelected)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectDate?(indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class DateSelectionTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthAgoLabel: UILabel!

    // MARK: - Helpers

    func configure(with monthInfo: MonthInfo, index: Int, isSelected: Bool) {
        monthLabel.text = monthInfo.date.YYMMFormat
        accessoryType = isSelected ? .checkmark : .none
        if index == 1 {
            monthAgoLabel.text = "1달 전"
        } else if index > 1 {
            monthAgoLabel.text = String(index) + "달 전"
        } else {
            monthAgoLabel.text = "현재"
        }
    }
}
