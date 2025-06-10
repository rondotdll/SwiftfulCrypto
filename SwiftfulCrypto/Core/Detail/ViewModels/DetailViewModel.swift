//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/28/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    
    @Published var coin: Coin
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatisticModels)
            .sink{(returnedArrays) in
//                print("RECEIVED COIN DETAIL DATA")
//                print(String(describing: returnedArrays.overview))
//                print(returnedArrays.additional)
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatisticModels(coinDetailModel: CoinDetail?, coinModel: Coin) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        
        
        return (
            createOverviewArray(coinModel: coinModel),
            createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        )
    }
    
    func createOverviewArray(coinModel: Coin) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.asAbbreviatedNumber() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.asAbbreviatedNumber() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    func createAdditionalArray(coinModel: Coin, coinDetailModel: CoinDetail?) -> [StatisticModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? ""
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? ""
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? ""
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.asAbbreviatedNumber() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime) min"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
//        let genesisDate = coinDetailModel?.genesisDate ?? "N/A"
//        let genesisStat = StatisticModel(title: "Genesis Date", value: genesisDate)
        
        return [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
    }
}
