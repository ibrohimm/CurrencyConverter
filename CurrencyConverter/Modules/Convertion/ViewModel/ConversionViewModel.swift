//
//  ConversionViewModel.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

final class ConversionViewModel: ObservableObject {
    @Published var fromCurrency: CurrencyCode = .USD
    @Published var toCurrency: CurrencyCode = .EUR
    @Published var convertedAmount: Double = 0
    
    private let currencyManager: CurrencyDataManageable
    
    init(currencyManager: CurrencyDataManageable) {
        self.currencyManager = currencyManager
    }
    
    // MARK: - Public
    
    func convert(for amount: Double) {
        currencyManager.convertAmount(with: amount, fromCurrency: fromCurrency, toCurrency: toCurrency)
        onMain { [weak self] in
            guard let self = self else { return }
            self.convertedAmount = currencyManager.convertedAmount
        }
    }
    
    func saveHistory() {
        currencyManager.saveHistory()
    }
    
    func loadLastCurrencyPair() {
        currencyManager.loadLastCurrencyPair()
        onMain { [weak self] in
            guard let self = self else { return }
            self.fromCurrency = currencyManager.lastCurrencyPair.base
            self.toCurrency = currencyManager.lastCurrencyPair.target
        }
    }
}
