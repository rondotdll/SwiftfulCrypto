//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack (spacing: 22) {
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)
                
                Text("Secondary Text Color")
                    .foregroundStyle(Color.theme.secondaryText)

                Text("Red Color")
                    .foregroundStyle(Color.theme.red)
                
                Text("Green Color")
                    .foregroundStyle(Color.theme.green)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
