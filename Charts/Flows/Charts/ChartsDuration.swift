//
//  ChartsDuration.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import Foundation

enum ChartsDuration {
    case week
    case month
    
    var title: String {
        switch self {
        case .week:
            return "Quotes week"
        case .month:
            return "Quotes month"
        }
    }
}
