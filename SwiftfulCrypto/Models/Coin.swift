//
//  CoinModel.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/13/25.
//

import Foundation


// MARK: - CoinModel
// bad practice, do NOT include "Model" in class names
struct Coin: Identifiable, Codable {
    
    // Gecko API Info
    /*
     URL:
     https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
     
     Sample Response JSON:
     {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 102474,
     "market_cap": 2033121318818,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 2033121318818,
     "total_volume": 40871408194,
     "high_24h": 105503,
     "low_24h": 101109,
     "price_change_24h": -1523.1684239816677,
     "price_change_percentage_24h": -1.46463,
     "market_cap_change_24h": -31477708706.46924,
     "market_cap_change_percentage_24h": -1.52464,
     "circulating_supply": 19864015.0,
     "total_supply": 19864015.0,
     "max_supply": 21000000.0,
     "ath": 108786,
     "ath_change_percentage": -6.26596,
     "ath_date": "2025-01-20T09:11:54.494Z",
     "atl": 67.81,
     "atl_change_percentage": 150276.89874,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2025-05-13T04:37:59.243Z",
     "sparkline_in_7d": {
     "price": [
     94719.67050036856,
     94553.5512061966,
     94311.76641275226,
     ...
     94288.01718818802,
     94409.2116200293,
     ]
     },
     "price_change_percentage_24h_in_currency": -1.4646316486506699
     }
     */
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    
    var currentHoldings: Double?
    
    func updateHoldings(amount: Double) -> Coin {
        var out: Coin = self
        out.currentHoldings = amount
        
        return out
    }
    
    var currentHoldingsConversion: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
