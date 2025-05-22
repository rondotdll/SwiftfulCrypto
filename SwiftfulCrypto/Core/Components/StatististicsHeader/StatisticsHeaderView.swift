//
//  StatisticsHeaderView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/22/25.
//

import SwiftUI

struct StatisticsHeaderView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.screenWidth / 3)
            }
        }
        .frame(width: UIScreen.screenWidth,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    StatisticsHeaderView(showPortfolio: .constant(false))
        .environmentObject(dev.sampleVM)
}
