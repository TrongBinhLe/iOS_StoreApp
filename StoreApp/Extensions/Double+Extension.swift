//
//  Double+Extension.swift
//  StoreApp
//
//  Created by admin on 08/06/2023.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self)) ?? "0.0"
    }
}
