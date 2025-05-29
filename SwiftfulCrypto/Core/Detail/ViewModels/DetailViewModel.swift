//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/28/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .sink{(receivedCoinDetails) in
                print("RECEIVED COIN DETAIL DATA \(receivedCoinDetails)")
            }
            .store(in: &cancellables)
    }
}
