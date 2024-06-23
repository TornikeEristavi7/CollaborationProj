//
//  CartManager.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private var cartItems: [ProductListModel] = []

    private init() {
        loadCart()
    }

    func addToCart(item: ProductListModel) {
        if let index = cartItems.firstIndex(where: { $0.product.id == item.product.id }) {
            cartItems[index].count += 1
        } else {
            var current = item
            current.count += 1
            cartItems.append(current)
            
        }
        saveCart()
    }

    func removeFromCart(item: ProductListModel) {
        if let index = cartItems.firstIndex(where: { $0.product.id == item.product.id }) {
            cartItems[index].count -= 1
            if cartItems[index].count == 0 {
                cartItems.remove(at: index)
            }
        }
        saveCart()
    }

    func getCartItems() -> [ProductListModel] {
        return cartItems
    }
    
    func cartInfo() -> (amount: Int, total: Double) {
        var totalcount = 0
        var totalPrice = 0.0
        
        for item in cartItems {
            totalcount += item.count
            totalPrice += Double(item.count) * item.product.price
        }
        return (totalcount, totalPrice.rounded(toPlaces: 2))
    }

    private func saveCart() {
        UserDefaults.standard.saveCartItems(cartItems)
    }

    private func loadCart() {
        cartItems = UserDefaults.standard.getCartItems()
    }
    
    func emtifyCart() {
        cartItems = []
        saveCart()
    }

}
