//
//  HistoryViewModel.swift
//  CurrencyConverter
//
//  Created by Ibrokhim Movlonov on 26/02/24.
//

import Foundation
import Combine

final class HistoryViewModel: ObservableObject {
    @Published var historyItems: [Conversion] = []
    @Published var filteredItems: [Conversion] = []
    @Published var searchText: String = ""
    @Published var isAscendingOrder = true
    
    private var cancellables = Set<AnyCancellable>()
    private let currencyManager: CurrencyDataManageable
    
    // MARK: - Init
    
    init(currencyManager: CurrencyDataManageable) {
        self.currencyManager = currencyManager
        setup()
    }
    
    // MARK: -
    
    func loadHistoryList() {
        historyItems = currencyManager.loadHistory()
        updateFilteredItems()
    }
    
    func toggleSortingOrder() {
        isAscendingOrder.toggle()
        sortHistoryItems()
    }
    
    // MARK: - Private
    
    private func setup() {
        $searchText
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.filteredItems = self.historyItems
                } else {
                    self.filteredItems = self.historyItems.filter {
                        $0.base.rawValue.localizedCaseInsensitiveContains(text) || $0.target.rawValue.localizedCaseInsensitiveContains(text)
                    }
                }
            }.store(in: &cancellables)
    }
    
    private func sortHistoryItems() {
        if isAscendingOrder {
            historyItems.sort { $0.timestamp < $1.timestamp }
        } else {
            historyItems.sort { $0.timestamp > $1.timestamp }
        }
        updateFilteredItems()
    }
    
    private func updateFilteredItems() {
        if searchText.isEmpty {
            filteredItems = historyItems
        } else {
            filteredItems = historyItems.filter {
                $0.base.rawValue.localizedCaseInsensitiveContains(searchText) || $0.target.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
