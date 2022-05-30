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
    
    // 전체 스택뷰
    private lazy var stackView = UIStackView(arrangedSubviews: [horizontalStackView1, horizontalStackView2]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
    }
    
    // 첫 번째 스택뷰
    
    private lazy var horizontalStackView1 = UIStackView(arrangedSubviews: [testLabel1, testLabel2]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    private let testLabel1 = UILabel().then {
        $0.text = "SPY"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 18)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private let testLabel2 = UILabel().then {
        $0.text = "S&P 500 ETF"
        $0.textColor = .lightGray
        $0.font = UIFont(name: "AvenirNext-Medium", size: 14)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    // 첫 번째 스택뷰 끝
    
    // 두 번째 스택뷰
    
    private lazy var verticalStackView1 = UIStackView(arrangedSubviews: [horizontalStackView2]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private lazy var horizontalStackView2 = UIStackView(arrangedSubviews: [testLabel3, testLabel4]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private let testLabel3 = UILabel().then {
        $0.text = "Current value"
        $0.font = UIFont(name: "AvenirNext-Demi-Bold", size: 12)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private let testLabel4 = UILabel().then {
        $0.text = "(USD)"
        $0.font = UIFont(name: "AvenirNext-Medium", size: 12)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    // 두 번째 스택뷰 끝
    
    // 세 번째 스택뷰
    private lazy var verticalStackView2 = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private lazy var horizontalStackView3 = UIStackView().then {
        $0.backgroundColor = .systemMint
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    // 세 번째 스택뷰 끝
    
    // 세 번째 스택뷰
    
    private lazy var verticalStackView3 = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    private lazy var horizontalStackView4 = UIStackView().then {
        $0.backgroundColor = .systemGreen
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    // 네 번째 스택뷰 끝
    
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
