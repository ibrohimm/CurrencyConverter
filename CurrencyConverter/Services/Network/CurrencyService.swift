//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

protocol CurrencyService {
    typealias Completion = Result<CurrencyDataModel, Error>
    
    func load(completion: @escaping (Completion) -> Void)
}
