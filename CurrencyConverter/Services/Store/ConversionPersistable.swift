//
//  ConversionPersistable.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

protocol ConversionPersistable {
    func saveConversion(_ conversion: Conversion)
    func loadConversionHistory() throws -> [Conversion]
}
