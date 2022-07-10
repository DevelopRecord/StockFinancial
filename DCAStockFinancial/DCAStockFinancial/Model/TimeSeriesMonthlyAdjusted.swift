//
//  TimeSeriesMonthlyAdjusted.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/10.
//

import Foundation

struct TimeSeriesMonthlyAdjusted: Decodable {
    let meta: Meta
    let timeSeries: [String: OHLC]
}

struct Meta: Decodable {
    var symbol: String

    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLC: Decodable {
    let open: String
    let close: String
    let adjustedClose: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}
