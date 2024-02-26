//
//  CurrencyCode.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

enum CurrencyCode: String, CaseIterable, Identifiable, Equatable, Codable {
    case CHF = "CHF"
    case CNY = "CNY"
    case EUR = "EUR"
    case GBP = "GBP"
    case RUB = "RUB"
    case USD = "USD"
    
    var id: String { rawValue }
    
    func currenciesQuery() -> String {
        "&currencies=" + CurrencyCode.allCases.map { $0.rawValue }.joined(separator: "%2C")
    }
    
    func baseCurrencyQuery() -> String {
        "&base_currency=\(rawValue)"
    }
}
