//
//  Locale+Extension.swift
//  StoreApp
//
//  Created by admin on 01/06/2023.
//

import Foundation

extension Locale {
    static var currentCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}
