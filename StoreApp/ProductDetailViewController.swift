//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by admin on 08/06/2023.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    let product: Product
    
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
        
    }
    
    private func layout() {
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(deleteButtonProduct)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)])
    }
    
}
