//
//  ViewController.swift
//  StoreApp
//
//  Created by admin on 01/06/2023.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    private var client = StoreHTTPClient()
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        Task {
            await populateCategories()
            tableView.reloadData()
        }
    }

    private func populateCategories() async {
        do {
            // categories = try await client.getAllCategories()
            // Another way is generic the URL resource.
            categories = try await client.load(Resource(url: URL.allCategories))
        } catch {
            // Todo: Show up the alert to show error.
        }
         
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        let category = categories[indexPath.row]
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = category.name
        
        if let url = URL(string: category.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        configuration.image = image
                        configuration.imageProperties.maximumSize = CGSize(width: 75, height: 75)
                        cell.contentConfiguration = configuration
                        
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        self.navigationController?.pushViewController(ProductsTableViewController(category: category), animated: true)
    }

}

