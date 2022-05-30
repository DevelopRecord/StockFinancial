//
//  SearchViewCell.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/29.
//

import UIKit

class SearchViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SearchViewCell"

    private lazy var stackView = UIStackView(arrangedSubviews: [leftVerticalStackView, rightVerticalStackView]).then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 16
    }

    private lazy var leftVerticalStackView = UIStackView(arrangedSubviews: [assetSymbolLabel, assetTypeLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
    }

    private lazy var rightVerticalStackView = UIStackView(arrangedSubviews: [assetNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .trailing
    }

    private let assetSymbolLabel = UILabel().then {
        $0.text = "BA"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
    }

    private let assetTypeLabel = UILabel().then {
        $0.text = "USD"
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }

    private let assetNameLabel = UILabel().then {
        $0.text = "The Boeing Company"
        $0.numberOfLines = 4
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
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
    
    func configure(with searchResult: SearchResult) {
        assetNameLabel.text = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text = searchResult.type.appending(" ").appending(searchResult.currency)
    }
}
