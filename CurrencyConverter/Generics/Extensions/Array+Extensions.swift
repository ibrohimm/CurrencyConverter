//
//  Array+Extensions.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

extension Array where Element == CurrencyPair {
    func getCrossRate(base: CurrencyCode, target: CurrencyCode) -> Double {
        let reversedBase = 1 / getRate(for: base)
        let targetRate = getRate(for: target)
        return reversedBase * targetRate
    }
    
    private func getRate(for currency: CurrencyCode) -> Double {
        guard !isEmpty else { return 0 }
        return filter { $0.target == currency }.first?.rate ?? 0
    }
}
