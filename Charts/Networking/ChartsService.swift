//
//  ChartsService.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import Foundation
import Moya

enum ChartsRequest {
    case fetchWeekInfo
    case fetchMonthInfo
}

class ChartsService: TargetType, AccessTokenAuthorizable {
    
    internal var chartsRequest: ChartsRequest
    
    init(_ chartsRequest: ChartsRequest) {
        self.chartsRequest = chartsRequest
    }
    
    var baseURL: URL {
        switch chartsRequest {
        case .fetchWeekInfo, .fetchMonthInfo:
            return Constants.baseURL
        }
    }
    
    var path: String {
        switch chartsRequest {
        case .fetchWeekInfo:
            return "stocks/week"
        case .fetchMonthInfo:
            return "stocks/month"
        }
    }
    
    var method: Moya.Method {
        switch chartsRequest {
        case .fetchWeekInfo, .fetchMonthInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        switch chartsRequest {
        case .fetchWeekInfo:
           return getData(from: "responseQuotesWeek", ofType: "json")
        case .fetchMonthInfo:
            return getData(from: "responseQuotesMonth", ofType: "json")
        }
    }
    
    var task: Task {
        switch chartsRequest {
        case .fetchWeekInfo, .fetchMonthInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    var authorizationType: AuthorizationType? {
        switch self {
        default:
            return .none
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

extension ChartsService {
    private func getData(from file: String, ofType: String) -> Data {
        if let path = Bundle.main.path(forResource: file, ofType: ofType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return Data()
            }
        }
        return Data()
    }
}
