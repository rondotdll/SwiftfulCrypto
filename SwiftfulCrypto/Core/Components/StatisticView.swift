//
//  StatisticView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/22/25.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentChange ?? 0) >= 0 ? 0 : 180)
                    )
                Text(stat.percentChange?.asNormalPercentage() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview("StatisticView Light") {
    HStack(spacing: 24) {
        StatisticView(stat: dev.stat1)
        StatisticView(stat: dev.stat2)
        StatisticView(stat: dev.stat3)
    }
}

#Preview("StatisticView Dark") {
    HStack(spacing: 24) {
        StatisticView(stat: dev.stat1)
        StatisticView(stat: dev.stat2)
        StatisticView(stat: dev.stat3)
    }.preferredColorScheme(.dark)
}
