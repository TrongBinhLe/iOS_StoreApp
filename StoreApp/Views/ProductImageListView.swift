//
//  ProductImageListView.swift
//  StoreApp
//
//  Created by admin on 09/06/2023.
//

import SwiftUI

struct ProductImageListView: View {
    
    let images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
    }
}

struct ProductImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageListView(images: [])
    }
}
