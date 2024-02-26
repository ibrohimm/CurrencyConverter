//
//  HistoryView.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var currencyManager: CurrencyDataManager
    @StateObject var viewModel = HistoryViewModel(currencyManager: CurrencyDataManager.shared)
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.filteredItems.isEmpty {
                    Text("No items saved.")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.filteredItems.reversed()) { conversion in
                            NavigationLink {
                                
                            } label: {
                                HStack {
                                    Text("\(conversion.base.rawValue) / \(conversion.target.rawValue)")
                                    Spacer()
                                    Text(conversion.timestamp.formatted(.dateTime))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Conversion History")
            .searchable(text: $viewModel.searchText)
            .onAppear {
                Task {
                    do {
                        try await viewModel.loadHistoryList()
                    } catch {}
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.toggleSortingOrder()
                    }) {
                        HStack {
                            Image(systemName: viewModel.isAscendingOrder ? "arrow.up" : "arrow.down")
                            Text("Sort")
                        }
                    }
                    .disabled(viewModel.filteredItems.isEmpty)
                }
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
    }
}

#Preview {
    HistoryView()
        .environmentObject(CurrencyDataManager.shared)
}
