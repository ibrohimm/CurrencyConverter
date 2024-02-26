//
//  CurrencyDataManagerError.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

enum CurrencyDataManagerError: Error, CustomStringConvertible {
    case noCurrencyRatesAvailable
    case noInternetConnection
    case failedToLoadCurrencyRates
    case failedToSaveCurrencyRates
    case failedToLoadLastCurrencyPair
    case failedToLoadHistory
    case failedToSaveHistory
    case unknown
    
    var localizedDescription: String {
        self.description
    }
    
    var description: String {
        switch self {
        case .noCurrencyRatesAvailable:
            return "No currency rates available"
        case .noInternetConnection:
            return "Failed to fetch currency rates. Please try later."
        case .failedToLoadCurrencyRates:
            return "Failed to load currency rates"
        case .failedToSaveCurrencyRates:
            return "Failed to save currency rates"
        case .failedToLoadLastCurrencyPair:
            return "Failed to load last chosen currency pair"
        case .failedToLoadHistory:
            return "Failed to load history list"
        case .failedToSaveHistory:
            return "Failed to save history list"
        case .unknown:
            return ""
        }
    }
}
