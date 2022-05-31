//
//  CalcaulatorViewSecondCell.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/31.
//

import UIKit

class CalcaulatorViewSecondCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "CalcaulatorViewSecondCell"

    private lazy var stackView = UIStackView(arrangedSubviews: [verticalStackView, verticalStackView2, verticalStackView3]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
    }

    // 첫번째 스택뷰
    private lazy var verticalStackView = UIStackView(arrangedSubviews: [investmentAmountLTextField, horizontalStackView]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let investmentAmountLTextField = UITextField().then {
        $0.placeholder = "투자량을 입력해 주세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
        $0.borderStyle = .none
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [initialInvestmentLabel, unitKindLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let initialInvestmentLabel = UILabel().then {
        $0.text = "최초투자량"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private let unitKindLabel = UILabel().then {
        $0.text = "(USD)"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 두번째 스택뷰
    private lazy var verticalStackView2 = UIStackView(arrangedSubviews: [monthlyDollarCostLTextField, horizontalStackView2]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let monthlyDollarCostLTextField = UITextField().then {
        $0.placeholder = "월 달러 평균 금액을 입력해 주세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
        $0.borderStyle = .none
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private lazy var horizontalStackView2 = UIStackView(arrangedSubviews: [monthlyDollarCostLabel, unitKindLabel2]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let monthlyDollarCostLabel = UILabel().then {
        $0.text = "월 달러 평균 금액"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private let unitKindLabel2 = UILabel().then {
        $0.text = "(USD)"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 세번째 스택뷰
    private lazy var verticalStackView3 = UIStackView(arrangedSubviews: [initialDateOfInvestmentTextField, horizontalStackView3, investmentAmountSlider]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 4
    }

    private let initialDateOfInvestmentTextField = UITextField().then {
        $0.placeholder = "최초 투자 일자를 입력해 주세요."
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
        $0.borderStyle = .none
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private lazy var horizontalStackView3 = UIStackView(arrangedSubviews: [initialDateOfInvestmentLabel, unitKindLabel3]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }

    private let initialDateOfInvestmentLabel = UILabel().then {
        $0.text = "최초투자일자"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private let unitKindLabel3 = UILabel().then {
        $0.text = "(USD)"
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    private var investmentAmountSlider = UISlider().then {
        $0.tintColor = .systemGreen
    }

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
}
