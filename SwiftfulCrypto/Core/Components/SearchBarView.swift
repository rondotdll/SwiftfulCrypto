//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/18/25.
//

import SwiftUI

struct SearchBarView: View {
    
    var placeholder: String = "Search by name or symbol..."
    @Binding var searchText: String
    
    @Environment(\.colorScheme) private var theme
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(isFocused ? Color.theme.accent : Color.theme.secondaryText.opacity(0.4))
            
            TextField(placeholder, text: $searchText)
                .autocorrectionDisabled()
                .focused($isFocused)
                .overlay(
                    Image(systemName: "xmark.circle")
                        .padding()
                        .foregroundStyle(Color.theme.secondaryText.opacity(0.8))
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                , alignment: .trailing)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 999)
                .fill(Color.theme.background)
                .stroke(isFocused ? Color.theme.accent : Color.clear, lineWidth: 1)
                .shadow(
                    color: Color.theme.accent.opacity((theme == .dark && isFocused) ? 0.45 : 0.25),
                    radius: 10, x: 0.0, y: 0.0
                )
        )
        .padding()
        .animation(.easeInOut(duration: 0.125), value: isFocused)
        .animation(.easeInOut(duration: 0.125), value: searchText.isEmpty)
    }
}

#Preview("SearchBarView - Light") {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.light)
}

#Preview("SearchBarView - Dark") {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}

