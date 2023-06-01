//
//  Product.swift
//  StoreApp
//
//  Created by admin on 01/06/2023.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let title: String
    let price: Double
    let description: String
    let category: Category
    let images: [URL]?
}
