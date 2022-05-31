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
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorViewCell.identifier, for: indexPath) as? CalculatorViewCell ?? CalculatorViewCell()
            return cell
        } else if indexPath.row == 1 {
            let secondCell = tableView.dequeueReusableCell(withIdentifier: CalcaulatorViewSecondCell.identifier, for: indexPath) as? CalcaulatorViewSecondCell ?? CalcaulatorViewSecondCell()
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
