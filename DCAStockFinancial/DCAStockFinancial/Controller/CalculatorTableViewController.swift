//
//  CalculatorTableViewController.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/10.
//

import UIKit

class CalculatorTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet var currencyLabels: [UILabel]!
    
    var asset: Asset?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        symbolLabel.text = asset?.searchResult.symbol
        assetNameLabel.text = asset?.searchResult.name
        currencyLabels.forEach { label in
            label.text = asset?.searchResult.currency.addBracket
        }
    }
}
