//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation

final class CurrencyDataManager: CurrencyDataManageable, ObservableObject {
    static let shared = CurrencyDataManager()
    
    @Published var currencyRates: [CurrencyPair] = []
    @Published var lastCurrencyPair: CurrencyPair = .placeholder
    @Published var historyList: [Conversion] = []
    @Published var errorMessage: String = ""
    @Published var convertedAmount: Double = 0.0
    
    private var timer: Timer?
    private let currencyStore: CurrencyStore
    
    // MARK: - Init
    
    init(currencyStore: CurrencyStore = .shared) {
        self.currencyStore = currencyStore
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // MARK: -
    
    func startRefreshRatesTimer(with currencyService: CurrencyService, timeInterval: TimeInterval, repeats: Bool = true, completion: (() -> ())? = nil) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: { [weak self] _ in
            guard let self = self else { return }
            
            self.fetchAllRates(with: currencyService)
            completion?()
        })
    }
    
    func getRates(with currencyService: CurrencyService) {
        do {
            try loadRates()
            if currencyRates.isEmpty {
                fetchAllRates(with: currencyService)
            }
        } catch {
            onMain { [weak self] in
                guard let self = self else { return }
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func saveRates() {
        if currencyRates.isEmpty { return }
        do {
            try currencyStore.saveRates(rates: currencyRates)
        } catch {
            onMain { [weak self] in
                guard let self = self else { return }
                self.errorMessage = "Failed to save exchange rates: " + error.localizedDescription
            }
        }
    }
    
    // MARK: - CurrencyDataManageable
    
    func convertAmount(with amount: Double, fromCurrency: CurrencyCode, toCurrency: CurrencyCode) {
        guard !currencyRates.isEmpty else {
            errorMessage = "No exchange rates available"
            return
        }
        
        let rate = currencyRates.getCrossRate(base: fromCurrency, target: toCurrency)
        guard rate > 0, amount > 0 else { return }
        convertedAmount = rate * amount
        
        let conversion = Conversion(base: fromCurrency, target: toCurrency, amount: amount, convertedAmount: convertedAmount, rate: rate, timestamp: .now)
        historyList.append(conversion)
    }
    
    func loadLastCurrencyPair() {
        do {
            let items = try currencyStore.loadConversionHistory().reversed()
            if let item = items.first {
                lastCurrencyPair = CurrencyPair(base: item.base, target: item.target, rate: 1)
            }
        } catch {
            onMain { [weak self] in
                guard let self = self else { return }
                self.errorMessage = "Failed to load last chosen currency pair: " + error.localizedDescription
            }
        }
    }
    
    func loadHistory() throws {
        do {
            let items = try currencyStore.loadConversionHistory()
            onMain {
                self.historyList = items
            }
        } catch {
            onMain { [weak self] in
                guard let self = self else { return }
                self.errorMessage = "Failed to load history list: " + error.localizedDescription
            }
        }
    }
    
    func saveHistory() {
        guard !historyList.isEmpty else { return }
        historyList.forEach { item in
            currencyStore.saveConversion(item)
        }
    }
    
    // MARK: - Private
    
    private func fetchAllRates(with currencyService: CurrencyService) {
        currencyService.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(model):
                onMain {
                    self.currencyRates = model.data.map { (key, value) in
                        let targetCurrency = CurrencyCode(rawValue: key) ?? .USD
                        return CurrencyPair(base: .USD, target: targetCurrency, rate: value)
                    }
                }
            case let .failure(error):
                onMain {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func loadRates() throws {
        do {
            let rates = try currencyStore.loadRates()
            onMain {
                self.currencyRates = rates
            }
        } catch {
            throw error
        }
    }
}
