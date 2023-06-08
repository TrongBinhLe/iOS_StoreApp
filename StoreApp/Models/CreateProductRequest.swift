//
//  CreateProductRequest.swift
//  StoreApp
//
//  Created by admin on 08/06/2023.
//

import Foundation

struct CreateProductRequest: Encodable {
    
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let image: [URL]
    
    init(product: Product) {
        self.title = product.title
        self.price = product.price
        self.description = product.description
        self.categoryId = product.category.id
        self.image = product.images ?? []
    }
}
