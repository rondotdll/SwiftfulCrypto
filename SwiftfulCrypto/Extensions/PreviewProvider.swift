//
//  PrewviewProvider.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/13/25.
//

import Foundation
import SwiftUI

let dev = DeveloperPreview.instance

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() { }
    
    let stat1 = StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let stat2 = StatisticModel(title: "Total Volume", value: "$1.23Tr")
    let stat3 = StatisticModel(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)
    
    let sampleVM = HomeViewModel()
    let sampleCoin = Coin(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 102474.82,
        marketCap: 2033121318818,
        marketCapRank: 1,
        fullyDilutedValuation: 2033121318818,
        totalVolume: 40871408194,
        high24H: 105503,
        low24H: 101109,
        priceChange24H: -1523.1684239816677,
        priceChangePercentage24H: -1.46463,
        marketCapChange24H: -31477708706.46924,
        marketCapChangePercentage24H: -1.52464,
        circulatingSupply: 19864015.0,
        totalSupply: 19864015,
        maxSupply: 21000000.0,
        ath: 108786,
        athChangePercentage: -6.26596,
        athDate: "2025-01-20T09:11:54.494Z",
        atl: 67.81,
        atlChangePercentage: 150276.89874,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-05-13T04:37:59.243Z",
        sparklineIn7D: SparklineIn7D(price: [
            94719.67050036856,
            94553.5512061966,
            94311.76641275226,
            94288.01718818802,
            94409.2116200293,
            94559.93816867477,
            94372.28734827018,
            94461.28594893696,
            94408.13275180699,
            94330.85226969632,
            94175.29764102303,
            93991.7353270022,
            93846.01249611624,
            93860.7540418781,
            93903.87572706376,
            94186.6533764946,
            94551.00991495204,
            94307.86688268195,
            94534.4462606627,
            95022.10980979039,
            94954.2912644009,
            94742.59542490661,
            95136.89593991211,
            96288.68626769505,
            96815.80313214885,
            97454.99383963464,
            97205.98482172143,
            96547.14987059082,
            96556.62015334367,
            96491.500021853,
            96354.63080106633,
            96538.03334234984,
            96925.96210528578,
            97003.63646893593,
            96986.15290872475,
            96986.48455649219,
            97017.36703189345,
            96968.99773463995,
            97041.28165831216,
            96946.47681288401,
            96941.07608759051,
            96863.98868038424,
            96212.81842184125,
            96306.502609734,
            96148.7571218679,
            96623.98416478802,
            97096.195573126,
            97277.49264928911,
            97035.80181467332,
            97921.8716635437,
            97950.20260938423,
            98712.46826631304,
            99037.21087966081,
            99095.08778875701,
            98684.10898485525,
            98990.04978777783,
            99109.17249310363,
            99645.29105191333,
            99763.50394686138,
            99810.2089598869,
            99572.56913879959,
            99380.82080975642,
            99445.01176371268,
            99883.30449934515,
            101783.94854609821,
            101397.34207827682,
            101112.06155180026,
            101327.33984258387,
            101156.28787384083,
            102715.70496819356,
            102898.7842378539,
            102946.60364931433,
            103155.55403424997,
            102755.01416938983,
            102981.92071790314,
            102602.6120856411,
            102431.38593811914,
            102735.23542016957,
            102936.7074812753,
            103654.43206932151,
            103775.85199443038,
            102941.5958896605,
            102847.4715321015,
            102942.94358657954,
            102928.84977016224,
            103635.59449072609,
            103081.79586234059,
            102895.00436299198,
            102560.61383641983,
            103192.42776451155,
            103241.92605940854,
            103117.03623118934,
            103209.3836430422,
            102977.49681924479,
            102827.52654028965,
            102974.90755054186,
            102888.53800348293,
            102993.94386197541,
            103150.34151496418,
            103193.12967175669,
            103175.63967376802,
            103323.707007908,
            103720.78075770468,
            103706.99371868216,
            103647.04618455893,
            103783.45760307356,
            103642.37117207838,
            103429.18395096257,
            103695.96296897363,
            103662.34239531834,
            103553.53694440117,
            103271.5104798415,
            103416.84977404175,
            103297.10860505837,
            103282.46567689025,
            103258.47973237954,
            103226.68575713312,
            103662.83631460686,
            103660.87510929449,
            104710.18767116882,
            104407.56428821298,
            104032.49982304672,
            103754.34752451746,
            104056.37170558948,
            104155.90999828055,
            103870.8841579018,
            103829.80918775442,
            103593.91838549759,
            103851.88885800124,
            104334.48684183184,
            104548.72450789883,
            104596.7005862239,
            104642.10789268535,
            104172.25933546464,
            104190.60953809322,
            104154.20587019669,
            103961.02518029482,
            104038.3347814099,
            104565.14537131102,
            104461.60521897068,
            104294.14065447195,
            104332.65737615807,
            103785.595389775,
            104083.02280094857,
            104632.60236125204,
            104010.92730451525,
            103878.99122372338,
            104025.9851010989,
            104015.37994237608,
            103922.92947191757,
            104385.93976669859,
            104345.64506752802,
            104580.96675487966,
            104442.91913640256,
            104427.94756195355,
            103839.45870520416,
            103996.90080969327,
            104265.08276082827,
            102956.96335456427,
            102540.50604756521,
            102896.58742159072,
            102638.94133473857,
            101758.10895980781,
            101821.24819695739,
            102722.17829371417,
            102535.07438971548,
            102853.64407073468
        ]),
        priceChangePercentage24HInCurrency: -1.4646316486506699,
        currentHoldings: 1.5
    )
}
