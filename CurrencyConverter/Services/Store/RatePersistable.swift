//
//  RatePersistable.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

protocol RatePersistable {
    func saveRates(rates: [CurrencyPair]) throws
    func loadRates() throws -> [CurrencyPair]
}
