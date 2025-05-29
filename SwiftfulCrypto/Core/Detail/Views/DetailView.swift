//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/28/25.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    var coin: Coin
    
    init(_ coin: Coin) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing detail view for \(coin.name ?? "NONE")...")
    }
    
    var body: some View {
        Text("\(coin.name)")
    }
}

#Preview {
    DetailView(dev.sampleCoin)
}
