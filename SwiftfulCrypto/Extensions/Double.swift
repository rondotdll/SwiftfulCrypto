//
//  Double.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/13/25.
//

import Foundation

extension Double {
    
    /// Converts Double() into a standard currency with 2 decimals places
    ///  ```
    ///  Convert 1234.56 to $1,234.56
    ///  Convert 12.3456 to $12.34
    ///  Convert 0.123456 to $0.12
    ///  ```
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Converts Double() into a currency with 2-6 decimals places
    ///  ```
    ///  Convert 1234.56 to $1,234.56
    ///  Convert 12.3456 to $12.3456
    ///  Convert 0.123456 to $0.123456
    ///  ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts Double() into a standard currency (2 decimals) String()
    ///  ```
    ///  Convert 1234.56 to $1,234.56
    ///  Convert 12.3456 to $12.34
    ///  Convert 0.123456 to $0.12
    ///  ```
    func asCurrency() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "NULL"
    }
    
    /// Converts Double() into a currency as a String() with 2-6 decimals places
    ///  ```
    ///  Convert 1234.56 to $1,234.56
    ///  Convert 12.3456 to $12.3456
    ///  Convert 0.123456 to $0.123456
    ///  ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "NULL"
    }
    
    /// Converts a Double() into a String() with 2 decimal places.
    /// ```
    /// Convert 1.23456 to "1.23"
    /// ```
    func asStringWith2Decimals() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double() into a percentage String() with 2 decimal places.
    /// ```
    /// Convert 1.23456 to "%1.23"
    /// ```
    func asNormalPercentage() -> String {
        return String(format: "%.2f", self) + "%"
    }
}
