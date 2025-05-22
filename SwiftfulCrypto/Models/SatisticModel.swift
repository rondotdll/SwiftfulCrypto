//
//  SatisticModel.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/22/25.
//

import Foundation
import Combine

struct StatisticModel: Identifiable {

    let id = UUID().uuidString
    let title: String
    let value: String
    let percentChange: Double?
 
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentChange = percentageChange
    }
    
}
