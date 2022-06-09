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
        let result = parseQuery(text: keywords)
        var keywords = String()
        
        switch result {
        case .success(let query):
            keywords = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        let resultUrl = parseURL(urlString: urlString)
        
        switch resultUrl {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: SearchResponse.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher() // 최종 데이터 전달하기 위해 사용
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchTimeSeriesMonthlyAdjusted(keywords: String) -> AnyPublisher<TimeSeriesMonthlyAdjusted, Error> {
        let result = parseQuery(text: keywords)
        var symbol = String()
        
        switch result {
        case .success(let query):
            symbol = query
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(symbol)&apikey=\(API_KEY))"
        let urlResult = parseURL(urlString: urlString)
        
        switch urlResult {
        case .success(let url):
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: TimeSeriesMonthlyAdjusted.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    private func parseQuery(text: String) -> Result<String, Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            return .failure(APIServiceError.encoding)
        }
    }
    
    private func parseURL(urlString: String) -> Result<URL, Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else {
            return .failure(APIServiceError.badRequest)
        }
    }
}
