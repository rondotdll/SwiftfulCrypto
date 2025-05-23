//
//  CoinLogoView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/23/25.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack{
            CoinImageView(coin: self.coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview("CoinLogoView - Light", traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: dev.sampleCoin)
        .preferredColorScheme(.light)
}

#Preview("CoinLogoView - Dark", traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: dev.sampleCoin)
        .preferredColorScheme(.dark)
}
