//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/13/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let dataService: CoinDataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.allCoins.append(DeveloperPreview.instance.sampleCoin) // Simulate having a coin
//            self.portfolioCoins.append(DeveloperPreview.instance.sampleCoin) // Simulate having a portfolio
//            
//        }
    }
    
    func addSubscribers() {
        
        // updates all coins based on search string
        $searchText
            .combineLatest(dataService.$allCoins)
            .map(filterCoins)
            .sink(receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let filteredSearchText = text.lowercased()
        
        return coins.filter{
            return $0.name.lowercased().contains(filteredSearchText) ||
                    $0.symbol.lowercased().contains(filteredSearchText) ||
                    $0.id.lowercased().contains(filteredSearchText)
        }
    }
}
