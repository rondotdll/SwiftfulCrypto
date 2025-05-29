//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/28/25.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetail? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    let localization: Bool = false
    let tickers: Bool = false
    let marketData: Bool = false
    let communityData: Bool = false
    let developerData: Bool = false
    let sparkline: Bool = false
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=\(localization)&tickers=\(tickers)&market_data=\(marketData)&community_data=\(communityData)&developer_data=\(developerData)&sparkline=\(sparkline)")
        else {return}
        
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinDetailSubscription = NetworkingManager.downloadData(url: url)
            .decode(type: CoinDetail.self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel() // close socket after initial response
            })
    }
}
