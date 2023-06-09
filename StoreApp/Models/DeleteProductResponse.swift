//
//  DeleteProductResponse.swift
//  StoreApp
//
//  Created by admin on 09/06/2023.
//

import Foundation

struct DeleteProductResponse: Decodable {
   
    var rta: Bool?
    var statusCode: Int?
    var message: String?
    var error: String?
}
