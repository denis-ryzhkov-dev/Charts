//
//  QuoteSymbol.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import Foundation

struct QuoteSymbol: Codable {
    let symbol: String
    let timestamps: [Int]
    let opens, closures, highs, lows: [Double]
    let volumes: [Int]
}
