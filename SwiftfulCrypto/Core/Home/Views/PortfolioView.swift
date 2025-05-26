//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/23/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var theme
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputForm
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    SheetCloseButton(dismiss: _dismiss)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    navbarSaveButton
                }
            }
            .background(Color.theme.background)
            .onChange(of: vm.searchText, perform: { text in
                if text == "" {
                    removeSelectedCoin()
                }
            })
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(dev.sampleVM)
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 70)
                        .padding(4)
                        .padding(.vertical, 8)
                        .onTapGesture{
                            withAnimation(.easeInOut(duration: 0.25)) {
                                updateSelectedCoin(coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.accent : Color.clear, lineWidth: 1)
                                .shadow(
                                    color: Color.theme.accent.opacity((theme == .dark && selectedCoin?.id == coin.id) ? 0.35 : 0),
                                    radius: 4, x: 0.0, y: 0.0
                                )
                                
                        )
                }
            }
            .frame(height: 120)
            .padding(.vertical, 8)
            .padding(.horizontal)
        })
        .scrollClipDisabled()
    }
    
    private var portfolioInputForm: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "" ): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrency() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holding: ")
                Spacer()
                TextField("Ex. 1.2345", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text("\(getCurrentValue().asCurrencyWith6Decimals())")
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var navbarSaveButton: some View {
        HStack(spacing: 10) {
            Button(action: {
                
                saveButtonPressed()
                
            }, label: {
                Image(systemName: "checkmark")
                    .opacity(showCheckmark ? 1 : 0)
                Text("Save".uppercased())
                    .underline(false)
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1 : 0
            )
            .foregroundStyle(Color.theme.accent)
            
        }
        .font(.headline)
    }
    
    private func updateSelectedCoin(_ coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}) {
            if let amount = portfolioCoin.currentHoldings {
                quantityText = "\(amount)"
            }
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
            
        // Save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeInOut) {
            showCheckmark = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeOut) {
                    removeSelectedCoin()
                }
            }
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
}
