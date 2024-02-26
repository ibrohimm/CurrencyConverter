//
//  ConversionDetailView.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import SwiftUI

struct ConversionDetailView: View {
    let viewModel: ConverionDetailViewModel
    
    var body: some View {
        Form {
            Section {
                Text(viewModel.dateTime)
                    .font(.title)
            } header: {
                Text("Date/Time")
            }
            
            Section {
                Text(viewModel.amount)
                    .font(.title3)
                Text(viewModel.converted)
                    .font(.title3)
            } header: {
                Text("Conversion")
            }
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    ConversionDetailView(viewModel: ConverionDetailViewModel(conversion: Conversion.placeholder))
}
