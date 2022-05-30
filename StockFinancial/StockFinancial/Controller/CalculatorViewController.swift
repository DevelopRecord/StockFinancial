//
//  CalculatorViewController.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/30.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.rowHeight = 150
        $0.delegate = self
        $0.dataSource = self
        
        $0.register(CalculatorViewCell.self, forCellReuseIdentifier: CalculatorViewCell.identifier)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
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

extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorViewCell.identifier, for: indexPath) as? CalculatorViewCell ?? CalculatorViewCell()
        return cell
    }
}
