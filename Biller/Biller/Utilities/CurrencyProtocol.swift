//
//  CurrencyProtocol.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation

public protocol CurrencyProtocol {
    var currencyCode: String { get set }
}

public extension CurrencyProtocol {
    public func convertCurrency(sum: Float) {
        
    }
}
