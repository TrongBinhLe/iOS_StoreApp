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
    
    lazy var addProductBarButtonItem: UIBarButtonItem = {
        let barItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductBarButtonitemPressed))
        return barItemButton
    }()
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        navigationItem.rightBarButtonItem = addProductBarButtonItem
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await populateProducts()
            tableView.reloadData()
        }
    }
    
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    private func layout() {
        
    }
    
    private func populateProducts() async {
        do {
//            products = try await client.getProductByCategory(categoryId: category.id)
            products = try await client.load(Resource(url: URL.productsByCategory(category.id)))
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
        cell.accessoryType = .disclosureIndicator
        let product = products[indexPath.row]
        
//        var configuration = cell.defaultContentConfiguration()
//        configuration.text = product.title
//        configuration.secondaryText = product.description
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductCellView(product: product)
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = products[indexPath.row]
        let productDetailVC = ProductDetailViewController(product: product)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
}

//MARK: Action

extension ProductsTableViewController {
    @objc func addProductBarButtonitemPressed(_ sender: UIBarButtonItem) {
        let addProductVC = AddProductViewController()
        addProductVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addProductVC)
        present(navigationController, animated: true)
    }
}

extension ProductsTableViewController: AddProductViewControllerDelegate {
    func addProductViewControllerDidCancel(vc: AddProductViewController) {
        vc.dismiss(animated: true)
    }
    
    func addProductViewControllerDidSave(vc: AddProductViewController, product: Product) {
        let createProductRequest = CreateProductRequest(product: product)
        
        Task {
            do{
//                let newProduct = try await client.createProduct(productRequest: createProductRequest)
                let data = try JSONEncoder().encode(createProductRequest)
                let newProduct: Product = try await client.load(Resource(url: URL.createProduct, method: .post(data)))
                products.insert(newProduct, at: 0)
                tableView.reloadData()
                vc.dismiss(animated: true)
            } catch {
               print(error)
            }
        }
    }
    
}
