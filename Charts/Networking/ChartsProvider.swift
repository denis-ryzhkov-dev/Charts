//
//  ChartsProvider.swift
//  Charts
//
//  Created by Denis Ryzhkov on 12.10.2020.
//

import Foundation
import Moya

final class ChartsProvider {
    
    // MARK: - Public Variables
    var provider: MoyaProvider<ChartsService>
    var stubProvider: MoyaProvider<ChartsService>
    
    // MARK: - Init
    init() {
        self.provider = MoyaProvider()
        self.stubProvider = MoyaProvider(stubClosure: MoyaProvider<ChartsService>.delayedStub(5))
    }
}
