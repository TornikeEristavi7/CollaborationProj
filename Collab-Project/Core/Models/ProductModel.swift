//
//  ProductModel.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 15.06.24.
//

struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    var stock: Int
    let thumbnail: String
    
}

struct ProductListModel: Codable {
    var product: ProductModel
    var count: Int
    
}

struct ResponseModel: Codable {
    let products: [ProductModel]
    
}
