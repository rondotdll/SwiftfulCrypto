//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/12/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // controls sliding animation
    @State private var showPortfolioView: Bool = false // controls new sheet visibility
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            VStack{
                homeHeader
                
                StatisticsHeaderView(showPortfolio: $showPortfolio)
                    .ignoresSafeArea(edges: .horizontal)
                    .padding(0)
                
                SearchBarView(searchText: $vm.searchText)
                
                coinRowHeaders
                
                ZStack {
                    allCoinsList
                        .offset(x: showPortfolio ? -UIScreen.screenWidth : 0)
                        .opacity(showPortfolio ? 0 : 1)
                    
                    portfolioCoinsList
                        .offset(x: showPortfolio ? 0 : UIScreen.screenWidth)
                        .opacity(showPortfolio ? 1 : 0)
                }.animation(.spring(response: 0.4, dampingFraction: 0.85), value: showPortfolio)
                
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(dev.sampleVM)
}

extension HomeView {
    
    private var coinRowHeaders: some View {
        HStack{
            Text("Coin")
            
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: (UIScreen.main.bounds.width / 3.5), alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus.diamond" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                        .foregroundStyle(Color.theme.accent)
                ).onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
    
            Spacer()
            HStack{
                Text(showPortfolio ? "Portfolio" : "Coin Prices")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.theme.accent)
                
                if !showPortfolio {
                    Text("LIVE")
                        .foregroundStyle(Color.white)
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(
                            Color.pink)
                        .clipShape(
                            RoundedRectangle(cornerSize: CGSize(
                                width: 2, height: 2)))
                }
            }
            Spacer()
            
            CircleButtonView(iconName: showPortfolio ? "arrowshape.forward" : "arrowshape.forward.fill")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 360))
            
                .onTapGesture {
                    withAnimation(.spring(duration: 0.25)) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
}
