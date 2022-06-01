//
//  CalculatorViewCell.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/30.
//

import UIKit

class CalculatorViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "CalculatorViewCell"
//    var currencyLabels = [unitKindLabel, unitKindLabel2]

    // 전체 스택뷰
    private lazy var stackView = UIStackView(arrangedSubviews: [horizontalStackView1, horizontalStackView2, investmentAmountLabel, horizontalStackView3, horizontalStackView4, horizontalStackView5]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    // 첫 번째 스택뷰

    private lazy var horizontalStackView1 = UIStackView(arrangedSubviews: [assetSymbolLabel, assetTypeLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 8
    }

    private let assetSymbolLabel = UILabel().then {
        $0.text = "SPY"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 18)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private let assetTypeLabel = UILabel().then {
        $0.text = "S&P 500 ETF"
        $0.textColor = .lightGray
        $0.font = UIFont(name: "AvenirNext-Medium", size: 14)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 첫 번째 스택뷰 끝

    // 두 번째 스택뷰

    private lazy var horizontalStackView2 = UIStackView(arrangedSubviews: [unitLabel, unitKindLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let unitLabel = UILabel().then {
        $0.text = "단위"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private let unitKindLabel = UILabel().then {
//        $0.text = "(USD)"
        $0.font = UIFont(name: "AvenirNext-Medium", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 두 번째 스택뷰 끝

    private let investmentAmountLabel = UILabel().then {
        $0.text = "5000"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 24)
    }

    // 세 번째 스택뷰

    private lazy var horizontalStackView3 = UIStackView(arrangedSubviews: [horizontalStackView10]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private lazy var horizontalStackView10 = UIStackView(arrangedSubviews: [investmentLabel, centerView, unitKindLabel2, costLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let investmentLabel = UILabel().then {
        $0.text = "투자량"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
    }

    private let centerView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let unitKindLabel2 = UILabel().then {
//        $0.text = "USD"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 11)
    }

    private let costLabel = UILabel().then {
        $0.text = "100"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 11)
    }

    // 세 번째 스택뷰 끝

    // 네 번째 스택뷰

    private lazy var horizontalStackView4 = UIStackView(arrangedSubviews: [horizontalStackView11]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private lazy var horizontalStackView11 = UIStackView(arrangedSubviews: [investmentLabel1, centerView1, currentEarningsRateLabel, amountOfEarnings]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let investmentLabel1 = UILabel().then {
        $0.text = "이익"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
    }

    private let centerView1 = UIView().then {
        $0.backgroundColor = .clear
    }

    private let amountOfEarnings = UILabel().then {
        $0.text = "+100.25"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 11)
    }

    private let currentEarningsRateLabel = UILabel().then {
        $0.text = "(+10.25%)"
        $0.textColor = .systemGreen
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 11)
    }
    // 네 번째 스택뷰 끝

    // 다섯번째 스택 뷰

    private lazy var horizontalStackView5 = UIStackView(arrangedSubviews: [horizontalStackView12]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private lazy var horizontalStackView12 = UIStackView(arrangedSubviews: [investmentLabel2, centerView2, earningsRateLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let investmentLabel2 = UILabel().then {
        $0.text = "연간 이익"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 11)
    }

    private let centerView2 = UIView().then {
        $0.backgroundColor = .clear
    }

    private let earningsRateLabel = UILabel().then {
        $0.text = "10.5%"
        $0.textColor = .systemGreen
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 11)
    }

    // 다섯번째 스택 뷰 끝

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configureUI() {
        contentView.backgroundColor = .secondarySystemBackground
    }

    private func configureConstraints() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(symbol: String, type: String, currency: String) {
        assetSymbolLabel.text = symbol
        assetTypeLabel.text = type
        unitKindLabel.text = currency.addBrackets()
        unitKindLabel2.text = currency.addBrackets()
    }
}
