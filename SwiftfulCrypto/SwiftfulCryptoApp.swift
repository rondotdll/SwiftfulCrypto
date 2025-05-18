//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/12/25.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
