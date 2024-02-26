//
//  CurrencyDataManager.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

protocol CurrencyDataManageable {
    var currencyRates: [CurrencyPair] { get set }
    var lastCurrencyPair: CurrencyPair { get set }
    var historyList: [Conversion] { get set }
    var errorMessage: String { get set }
    var convertedAmount: Double { get set }
    
    func convertAmount(with amount: Double, fromCurrency: CurrencyCode, toCurrency: CurrencyCode)
    func loadLastCurrencyPair()
    func loadHistory() throws
    func saveHistory()
}
