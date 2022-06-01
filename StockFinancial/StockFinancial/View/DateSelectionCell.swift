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
        
    }
}
