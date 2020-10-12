//
//  ChartsViewModel.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import Foundation

class ChartsViewModel {
    
    //MARK: - Properties
    private var provider = ChartsProvider().stubProvider
    var duration: ChartsDuration = .week
    
    
    //MARK: - Requests
    func fetchQuotes(successCompletion: @escaping ([QuoteSymbol])->(), errorCompletion: @escaping (String)->()) {
        let chartRequest: ChartsRequest
        switch duration {
        case .week:
            chartRequest = .fetchWeekInfo
        case .month:
            chartRequest = .fetchMonthInfo
        }
            
        provider.request(ChartsService(chartRequest)) { (result) in
            switch result {
            case .success(let response):
                guard let rootQuoteResponse = try? response.map(RootQuoteResponse.self) else {
                    let message = "Data is unavailable now. Please try again later."
                    errorCompletion(message)
                    return
                }
                
                successCompletion(rootQuoteResponse.content.quoteSymbols)
            case .failure(let error):
                errorCompletion(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Perfomance
    func calculatePerformance(for quote: QuoteSymbol) -> [(value: Double, timestamp: Int)] {
        guard let basePrice = quote.opens.first else { return [] }
        let performance = zip(quote.opens, quote.timestamps).map { (element) -> (value: Double, timestamp: Int) in
            let difference = element.0 / basePrice
            let percents = difference * 100
            let changeInPercent = percents - 100
            return (value: changeInPercent, timestamp: element.1)
        }
        return performance
    }
}
