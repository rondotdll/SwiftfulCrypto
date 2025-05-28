//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/14/25.
//

import Foundation
import Combine

// decoder.keyDecodingStrategy = .convertFromSnakeCase

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    
    var coinSubscription: AnyCancellable?
    
    private let vsCurrency: String = "usd"
    private let order: String = "market_cap_desc"
    private let perPage: Int = 250
    private let page: Int = 1
    private let sparkline: Bool = true
    private let priceChangePercentage: String = "24h"
    
    init() {
        getCoins()
    }
    
    public func getCoins() {
        
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(vsCurrency)&order=\(order)&per_page=\(perPage)&page=\(page)&sparkline=\(sparkline)&price_change_percentage=\(priceChangePercentage)") else { return }
        
        // MARK: --Remember to learn Swift Combine--
        
        coinSubscription = NetworkingManager.downloadData(url: url)
            .decode(type: [Coin].self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel() // free threadspace after first response
            })
    }
    
}
