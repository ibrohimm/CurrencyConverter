//
//  TabBarView.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var currencyManager: CurrencyDataManager
    
    var body: some View {
        TabView {
            ConversionView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Convert")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "list.bullet.circle.fill")
                    Text("History")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    TabBarView()
        .environmentObject(CurrencyDataManager.shared)
}
