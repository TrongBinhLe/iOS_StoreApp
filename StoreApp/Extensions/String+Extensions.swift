//
//  String+Extensions.swift
//  StoreApp
//
//  Created by admin on 07/06/2023.
//

import Foundation

extension String {
     
    var isNummeric: Bool {
        Double(self) != nil
    }
}
