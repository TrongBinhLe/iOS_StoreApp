//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by admin on 08/06/2023.
//

import Foundation
import UIKit
import SwiftUI

class ProductDetailViewController: UIViewController {
    
    let product: Product
    let client = StoreHTTPClient()
    
    let stackView = UIStackView()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    lazy var deleteButtonProduct: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    lazy var loadingIndicatorView: UIActivityIndicatorView = {
       let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        
        return activityIndicatorView
    }()
    
    init(product: Product){
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = product.title
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        style()
        layout()
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.alignment = .top
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        descriptionLabel.text = product.description
        priceLabel.text = product.price.formatAsCurrency()
        
        var images: [UIImage] = []
        Task {
            loadingIndicatorView.startAnimating()
            for imageURL in (product.images ?? []) {
                guard let downloadImage = try? await ImageLoader.load(url: imageURL) else { return }
                images.append(downloadImage)
            }
            /// Adding the product image list view to the product view controller.
            let productImageListVC = UIHostingController(rootView: ProductImageListView(images: images))
            guard let productImageListView = productImageListVC.view else { return }
            stackView.insertArrangedSubview(productImageListView, at: 0)
            self.addChild(productImageListVC)
            productImageListVC.didMove(toParent: self)
            loadingIndicatorView.stopAnimating()
        }
        
        deleteButtonProduct.addTarget(self, action: #selector(deleteButtonProductPressed), for: .touchUpInside)
    }
    
    private func layout() {
        stackView.addArrangedSubview(loadingIndicatorView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(deleteButtonProduct)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        

    }
    
}

// MARK: Actions
extension ProductDetailViewController {
    
    @objc private func deleteButtonProductPressed(_ sender: UIButton) {
        Task {
            do {
                guard let productId = product.id else {
                    return
                }
                let isDeleted = try await client.deleteProduct(productId: productId)
                if isDeleted {
                    let _ = navigationController?.popViewController(animated: true)
                }
            } catch {
                showMessage(title: "Error", message: "Unable to delete the product. Please check the productId", messageType: .error)
            }
        }
    }
}
