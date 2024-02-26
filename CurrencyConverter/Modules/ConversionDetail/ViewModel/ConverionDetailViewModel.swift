//
//  ConverionDetailViewModel.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

struct ConverionDetailViewModel {
    let conversion: Conversion
    
    var title: String {
        "\(conversion.base.rawValue)/\(conversion.target.rawValue)"
    }
    
    var dateTime: String {
        "\(conversion.timestamp.formatted(.dateTime))"
    }
    
    var amount: String {
        "Amount: \(conversion.amount.formatted(.currency(code: conversion.base.rawValue)))"
    }
    
    var converted: String {
        "Converted: \(conversion.convertedAmount.formatted(.currency(code: conversion.target.rawValue)))"
    }
}
