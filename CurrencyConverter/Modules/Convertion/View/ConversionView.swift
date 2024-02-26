//
//  ConversionView.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import SwiftUI

struct ConversionView: View {
    @EnvironmentObject var currencyManager: CurrencyDataManager
    @StateObject var viewModel = ConversionViewModel(currencyManager: CurrencyDataManager.shared)
    @State private var amount: String = ""
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        List {
            VStack {
                Text("Currency Converter")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color(UIColor.systemBlue))
                
                Image("currency-exchange")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .listRowSeparator(.hidden)
            
            Picker("Base Currency", selection: $viewModel.fromCurrency) {
                ForEach(CurrencyCode.allCases) {
                    Text($0.rawValue).tag($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .listRowSeparator(.hidden)
            
            Picker("Target Currency", selection: $viewModel.toCurrency) {
                ForEach(CurrencyCode.allCases) {
                    Text($0.rawValue).tag($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .listRowSeparator(.hidden)
            .onChange(of: viewModel.toCurrency) { _, _ in
                viewModel.convertedAmount = 0
            }
            
            VStack {
                TextField("Amount", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                Button("Check Rates") {
                    viewModel.convert(for: Double(amount) ?? 0)
                    viewModel.saveHistory()
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
                .padding(.bottom)
                .disabled(!isFormValid)
            }
            
            Section(header: Text("Convertion")) {
                Text("\(viewModel.convertedAmount.formatted(.currency(code: viewModel.toCurrency.rawValue)))")
                    .font(.headline)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .task {
            viewModel.loadLastCurrencyPair()
        }
        .onReceive(currencyManager.$errorMessage, perform: { _ in
            showErrorAlert = !currencyManager.errorMessage.isEmpty
        })
        .alert("Error: \(currencyManager.errorMessage)", isPresented: $showErrorAlert) {
            VStack {
                Button("Close", role: .cancel) {}
            }
        }
    }
    
    private var isFormValid: Bool {
        !amount.isEmptyOrWhiteSpace && Double(amount) != nil
    }
}

#Preview {
    ConversionView()
        .environmentObject(CurrencyDataManager.shared)
}
