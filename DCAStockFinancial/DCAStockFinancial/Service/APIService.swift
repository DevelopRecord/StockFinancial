//
//  APIService.swift
//  DCAStockFinancial
//
//  Created by LeeJaeHyeok on 2022/07/09.
//

import Foundation
import Combine

struct APIService {
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }

    let keys = ["3IHWFQO1ST7JOEEW", "OK2BD1ZHZHM2SBFN", "ZK3BSPGTFIVWOMCL"]

    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"

        let url = URL(string: urlString)!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
