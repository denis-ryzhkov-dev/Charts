//
//  BaseQuoteResponse.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import Foundation

struct BaseQuoteResponse: Codable {
    let content: QuoteContent
    let status: String
}
