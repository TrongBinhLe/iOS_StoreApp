//
//  ProductsTableViewController.swift
//  StoreApp
//
//  Created by admin on 01/06/2023.
//

import Foundation
import UIKit
import SwiftUI

class ProductsTableViewController: UITableViewController {
    
    private var category: Category
    private var client = StoreHTTPClient()
    private var products: [Product] = []
    
    init(category: Category){
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.name
        navigationController?.navigationBar.prefersLargeTitles = true
        Task {
            await populateProducts()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func populateProducts() async {
        do {
            products = try await client.getProductByCategory(categoryId: category.id)
            tableView.reloadData()
        } catch {
            //To do: Show alert popup
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        let product = products[indexPath.row]
        
//        var configuration = cell.defaultContentConfiguration()
//        configuration.text = product.title
//        configuration.secondaryText = product.description
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductCellView(product: product)
        })
        
        return cell
    }
    
}
