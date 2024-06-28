//
//  ProductsManager.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation

class ProductsManager {
    
    static let shared = ProductsManager()
    
    private var products: [ProductListModel] = []
    
    private init() {
        loadProducts()
    }
    
    func addToCart(item: ProductListModel) {
        guard let index = products.firstIndex(where: { $0.product.id == item.product.id }) else { return }
        products[index].count += 1
        updateProducts()
    }
    
    func removeFromCart(item: ProductListModel) {
        guard let index = products.firstIndex(where: { $0.product.id == item.product.id }) else { return }
        products[index].count -= 1
        updateProducts()
    }
    
    func clearCart() {
        products = products.map { item in
            var updatedItem = item
            if item.count > 0 {
                updatedItem.product.stock -= item.count
                updatedItem.count = 0
            }
            return updatedItem
        }
        updateProducts()
    }
    
    private func updateProducts() {
        UserDefaults.standard.saveProducts(products)
    }
        
    private func loadProducts() {
        products = UserDefaults.standard.getproducts()
    }

}
