//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/23/25.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketData? = nil
    
    var marketDataSubscription: AnyCancellable?

    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.downloadData(url: url)
            .decode(type: GlobalMarketData.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalMarketData) in
                self?.marketData = returnedGlobalMarketData.data
                self?.marketDataSubscription?.cancel() // free threadspace after first response
            })
    }
    
}
