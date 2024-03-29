//
//  CurrencyPair.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation
import SwiftData

@Model
final class CurrencyPair: Identifiable {
    let id = UUID()
    let base: CurrencyCode
    let target: CurrencyCode
    let rate: Double
    let timestamp: Date
    
    init(base: CurrencyCode, target: CurrencyCode, rate: Double, timestamp: Date) {
        self.base = base
        self.target = target
        self.rate = rate
        self.timestamp = timestamp
    }
}

extension CurrencyPair {
    static var placeholder: CurrencyPair {
        CurrencyPair(base: .USD, target: .EUR, rate: 0.92121, timestamp: .now)
    }
}
