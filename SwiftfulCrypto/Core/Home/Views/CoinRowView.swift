//
//  CoinRowView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/13/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack (spacing: 0){
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            rightColumn
            
        }
        .font(.subheadline)
        .background(Color.theme.background)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    CoinRowView(coin: dev.sampleCoin, showHoldingsColumn: false)
        .colorScheme(.light)
    
    CoinRowView(coin: dev.sampleCoin, showHoldingsColumn: false)
        .colorScheme(.dark)
    
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack (spacing: 0) {
            Text(String(coin.rank))
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: self.coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.primaryText)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsConversion.asCurrency())
                .bold()
                .foregroundColor(Color.theme.primaryText)
            Text((coin.currentHoldings ?? 0).asStringWith2Decimals())
                .foregroundColor(Color.theme.secondaryText)
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asNormalPercentage() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.green : Color.theme.red
                )
        }.frame(width: (UIScreen.main.bounds.width / 3.5), alignment: .trailing)
    }
}
