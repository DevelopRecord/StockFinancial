//
//  Date+.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/06/09.
//

import UIKit

extension Date {
    var YYMMFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM"
        return dateFormatter.string(from: self)
    }
}
