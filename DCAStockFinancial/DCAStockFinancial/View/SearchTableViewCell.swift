//
//  SearchTableViewCell.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/09.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetTypeLabel: UILabel!

    // MARK: - Helpers

    func configure(with searchResult: SearchResult) {
        assetNameLabel.text = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text = searchResult.type
            .appending(" ")
            .appending(searchResult.currency)
    }
}
