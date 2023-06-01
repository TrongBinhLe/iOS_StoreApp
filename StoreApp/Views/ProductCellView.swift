//
//  ProductCellView.swift
//  StoreApp
//
//  Created by admin on 01/06/2023.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                Text(product.title).bold()
                Text(product.description)
            }
            Spacer()
            Text(product.price, format: .currency(code: Locale.currentCode))
            
        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product(id: nil, title: "Handmade Fresh Table", price: 345, description: "Andy shoes are designed to keeping in ", category: Category(id: 1, name: "Clothes", image: "https://placeimg.com/640/480/any?r=0.591926261873231"), images: [URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!]))
    }
}
