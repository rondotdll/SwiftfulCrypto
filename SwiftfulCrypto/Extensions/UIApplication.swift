//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/18/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
