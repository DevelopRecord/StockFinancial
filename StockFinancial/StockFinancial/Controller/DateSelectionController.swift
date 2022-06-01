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
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(DateSelectionCell.self, forCellReuseIdentifier: DateSelectionCell.identifier)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    init(asset: Asset, timeSeriesMonthlyAdjusted: TimeSeriesMonthlyAdjusted) {
        self.asset = asset
        self.timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted
        print("2222222. \(timeSeriesMonthlyAdjusted)")
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
}

extension DateSelectionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateSelectionCell.identifier, for: indexPath) as? DateSelectionCell ?? DateSelectionCell()
        return cell
    }
}
