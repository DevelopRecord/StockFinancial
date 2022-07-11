//
//  Date+.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/11.
//

import UIKit

extension Date {
    /// 날짜를 yyyy MM 포맷 방식으로 변경
    var YYMMFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM"
        return dateFormatter.string(from: self)
    }
}
