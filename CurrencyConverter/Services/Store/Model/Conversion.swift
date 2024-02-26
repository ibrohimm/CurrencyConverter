//
//  Conversion.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation
import SwiftData

@Model
final class Conversion: Identifiable {
    let id = UUID()
    let base: CurrencyCode
    let target: CurrencyCode
    let amount: Double
    let convertedAmount: Double
    let rate: Double
    let timestamp: Date
    
    init(base: CurrencyCode, target: CurrencyCode, amount: Double, convertedAmount: Double, rate: Double, timestamp: Date) {
        self.base = base
        self.target = target
        self.amount = amount
        self.convertedAmount = convertedAmount
        self.rate = rate
        self.timestamp = timestamp
    }
}

extension Conversion {
    static var placeholder: Conversion {
        Conversion(base: .USD, target: .EUR, amount: 100, convertedAmount: 92.50, rate: 0.92121, timestamp: .now)
    }
}
