//
//  SearchResults.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/29.
//

import Foundation

struct SearchResponse: Decodable {
    var items: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
}

struct SearchResult: Decodable {
    var symbol: String
    var name: String
    var type: String
    var currency: String

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}
