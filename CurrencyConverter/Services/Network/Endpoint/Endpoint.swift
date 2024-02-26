//
//  Endpoint.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

enum Endpoint {
    static let apiKey = "fca_live_tCmemj2HLyCP5iVCS1gqAr0JkbzuD0x2Mne0UEE1"
    
    static let baseURL = "https://api.freecurrencyapi.com/v1/latest?apikey=\(apiKey)"
    
    // MARK: -
    
    static var getCurrencyRatesURL: URL? {
        let baseCurrency: CurrencyCode = .USD
        let urlString = baseURL + baseCurrency.currenciesQuery() + baseCurrency.baseCurrencyQuery()
        return URL(string: urlString)
    }
}
