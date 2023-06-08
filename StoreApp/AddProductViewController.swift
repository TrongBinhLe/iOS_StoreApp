//
//  AddProductViewController.swift
//  StoreApp
//
//  Created by admin on 02/06/2023.
//

import Foundation
import UIKit
import SwiftUI

enum AddProductTextFieldType: Int {
    case title
    case price
    case imageUrl
}

struct AddProductionFormState {
    var title: Bool = false
    var price: Bool = false
    var imageUrl: Bool = false
    var description: Bool = false
    var isValid: Bool {
        title && price && imageUrl && description
    }
}

class AddProductViewController: UIViewController {
    
    let stackView = UIStackView()
    private var selectedCategory: Category?
    private var addProductionFormState = AddProductionFormState()
    
    lazy var saveBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarButtonPressed))
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    
    lazy var cancelBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonItemPressed))
        
        return barButtonItem
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.tag = AddProductTextFieldType.title.rawValue
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter price (Number only)"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.keyboardType = .namePhonePad
        textField.tag = AddProductTextFieldType.price.rawValue
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.backgroundColor = .lightGray
        textView.delegate = self
        
        return textView
    }()
    
    lazy var imageURLTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter image url"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.tag = AddProductTextFieldType.imageUrl.rawValue
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    lazy var categoryPickerView: CategoryPickerView = {
        let pickerView = CategoryPickerView { [weak self] category in
            print(category)
            self?.selectedCategory = category
        }
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = saveBarButtonItem
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        style()
        layout()
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
    }
    
    private func layout() {
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(descriptionTextView)
        
        // category picker view
        let hostingController = UIHostingController(rootView: categoryPickerView)
        stackView.addArrangedSubview(hostingController.view)
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        
        stackView.addArrangedSubview(imageURLTextField)
        
        view.addSubview(stackView)
        
        //add constraints
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        descriptionTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

struct AddProductViewControllerResentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        UINavigationController(rootViewController: AddProductViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct AddProductViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddProductViewControllerResentable()
    }
}

// MARK: Action
extension AddProductViewController {
    
    @objc private func cancelButtonItemPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        
        guard let text = sender.text else { return }
        
        switch sender.tag {
        case AddProductTextFieldType.title.rawValue:
            addProductionFormState.title = !text.isEmpty
        case AddProductTextFieldType.price.rawValue:
            addProductionFormState.price = !text.isEmpty && text.isNummeric
        case AddProductTextFieldType.imageUrl.rawValue:
            addProductionFormState.imageUrl = !text.isEmpty
        default:
            break
        }
        
        saveBarButtonItem.isEnabled = addProductionFormState.isValid
    }
}

extension AddProductViewController:  UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        addProductionFormState.description = !textView.text.isEmpty
        saveBarButtonItem.isEnabled = addProductionFormState.isValid
    }
}
