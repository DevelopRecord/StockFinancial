//
//  APIService.swift
//  StockFinancial
//
//  Created by LeeJaeHyeok on 2022/05/29.
//

import Foundation
import Combine

enum APIServiceError: Error {
    case encoding
    case badRequest
}

struct APIService {

    static let shared = APIService()

    var API_KEY: String {
        return keys.randomElement() ?? ""
    }

    let keys = ["3IHWFQO1ST7JOEEW", "OK2BD1ZHZHM2SBFN", "ZK3BSPGTFIVWOMCL"]

    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResponse, Error> {
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return Fail(error: APIServiceError.encoding).eraseToAnyPublisher() }
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        guard let url = URL(string: urlString) else { return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher() // 최종 데이터 전달하기 위해 사용
    }
}
