//
//  SheetCoseButton.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/23/25.
//

import SwiftUI

struct SheetCloseButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color.theme.secondaryText)
                .font(.headline)
        })
    }
}

#Preview {
    SheetCloseButton()
}
