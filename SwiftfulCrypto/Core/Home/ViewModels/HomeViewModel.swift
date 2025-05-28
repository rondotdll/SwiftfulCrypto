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
    @Published var stats: [StatisticModel] = []
    
    @Published var isLoading: Bool = false
    
    private let coinDataService: CoinDataService = CoinDataService()
    private let marketDataService: MarketDataService = MarketDataService()
    private let portfolioDataService: PortfolioDataService = PortfolioDataService()
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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // latency buffer to prevent CPU overload
            .map(filterCoins)
            .sink(receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
        
        // updates portfolio contents
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapCoinsToPorfolioCoins)
            .sink{ [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
            
        // updates market data (statistics)
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(marketDataParser)
            .sink{ [weak self] (returnedStats) in
                self?.stats.append(contentsOf: returnedStats)
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin, amount: amount)
    }
    
    func reloadRemoteData() {
        HapticManager.notification(.success)
        
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
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
    
    private func mapCoinsToPorfolioCoins(coinModels: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        coinModels
            .compactMap{ (coin) -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id })
                    else {
                        return nil
                    }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func marketDataParser(marketDataModel: MarketData?, portfolioCoins: [Coin]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let marketVolume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingsConversion})
            .reduce(0, +)
        
        let prevPortfolioValue = portfolioCoins
            .map({
                $0.currentHoldingsConversion / (1 + (($0.priceChangePercentage24H ?? 0) / 100))
            })
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - prevPortfolioValue) / portfolioValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrency(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            marketVolume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
}
