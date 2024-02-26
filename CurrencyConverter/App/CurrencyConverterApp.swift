//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 25/02/24.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    let networkService = FreeCurrencyService()
    @StateObject var currencyManager = CurrencyDataManager.shared
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(currencyManager)
                .onAppear {
                    currencyManager.startRefreshRatesTimer(with: networkService, timeInterval: 180)
                    currencyManager.getRates(with: networkService)
                    currencyManager.loadHistory()
                }
                .onChange(of: scenePhase) { oldValue, newValue in
                    if newValue == .background || newValue == .inactive {
                        if !currencyManager.currencyRates.isEmpty {
                            currencyManager.saveRates()
                        }
                    }
                }
        }
    }
}
