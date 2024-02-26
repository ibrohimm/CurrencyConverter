//
//  CurrencyStore.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation
import SwiftData

final class CurrencyStore: RatePersistable, ConversionPersistable {
    private let modelContext: ModelContext
    
    var modelContainer: ModelContainer = {
        let schema = Schema([
            CurrencyPair.self,
            Conversion.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, allowsSave: true)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @MainActor
    static let shared = CurrencyStore()
    
    @MainActor
    private init() {
        self.modelContext = modelContainer.mainContext
    }
    
    // MARK: - ConversionPersistable
    
    func saveConversion(_ conversion: Conversion) {
        modelContext.insert(conversion)
    }
    
    func loadConversionHistory() throws -> [Conversion] {
        do {
            return try modelContext.fetch(FetchDescriptor<Conversion>())
        } catch {
            throw error
        }
    }
    
    // MARK: - RatePersistable
    
    func saveRates(rates: [CurrencyPair]) throws {
        do {
            let items = try loadRates()
            if let item = items.first {
                if item.timestamp.addingTimeInterval(180) > Date() {
                    try modelContext.delete(model: CurrencyPair.self)
                    try updateRates(rates)
                }
            } else {
                try updateRates(rates)
            }
        } catch {
            throw error
        }
    }
    
    func loadRates() throws -> [CurrencyPair] {
        do {
            return try modelContext.fetch(FetchDescriptor<CurrencyPair>())
        } catch {
            throw error
        }
    }
    
    fileprivate func updateRates(_ rates: [CurrencyPair]) throws {
        rates.forEach { item in
            modelContext.insert(item)
        }
    }
}
