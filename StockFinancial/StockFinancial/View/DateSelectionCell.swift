//
//  DateSelectionCell.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/06/01.
//

import UIKit

class DateSelectionCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "DateSelectionCell"
    
    private lazy var stackView = UIStackView(arrangedSubviews: [monthLabel, monthAgoLabel]).then {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
    }
    
    private let monthLabel = UILabel().then {
        $0.text = "December 2020"
        $0.font = UIFont(name: "AvenirNext-Medium", size: 18)
    }
    
    private let monthAgoLabel = UILabel().then {
        $0.text = "Recent"
        $0.textColor = .darkGray
        $0.font = UIFont(name: "AvenirNext-Regular", size: 12)
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
        backgroundColor = .secondarySystemBackground
    }
    
    private func configureConstraints() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with monthInfo: MonthInfo, index: Int, isSelected: Bool) {
        monthLabel.text = monthInfo.date.YYMMFormat
        accessoryType = isSelected ? .checkmark : .none
        if index == 1 {
            monthAgoLabel.text = "1개월 전"
        } else if index > 1 {
            monthAgoLabel.text = String(index) + " 개월 전"
        } else {
            monthAgoLabel.text = "과거 투자함"
        }
    }
}
