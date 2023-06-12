//
//  CategoryPickerView.swift
//  StoreApp
//
//  Created by admin on 07/06/2023.
//

import SwiftUI

struct CategoryPickerView: View {
    
    let client = StoreHTTPClient()
    @State private var categories: [Category] = []
    @State private var selectedCategory: Category?
    
    let onSelected: (Category) -> Void
    
    var body: some View {
        Picker("Category", selection: $selectedCategory){
            ForEach(categories,id: \.id) { category in
                Text(category.name).tag(Optional(category))
            }
        }.onChange(of: selectedCategory, perform: { category in
            if let category {
                onSelected(category)
            }
        })
        .pickerStyle(.wheel)
        .task {
            do {
//                categories = try await client.getAllCategories()
                categories = try await client.load(Resource(url: URL.allCategories))
                selectedCategory = categories.first
            } catch {
                print(error)
            }
        }
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(onSelected: { _ in })
    }
}
