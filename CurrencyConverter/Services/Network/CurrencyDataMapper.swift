//
//  CurrencyDataMapper.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

final class CurrencyDataMapper {
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> CurrencyDataModel {
        guard response.statusCode == 200, let root = try? JSONDecoder().decode(CurrencyDataModel.self, from: data) else {
            throw FreeCurrencyService.Error.invalidData
        }
        
        return root
    }
}
