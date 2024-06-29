//
//  Userdefaults-extensions.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let productItems = "products"
        static let cartItems = "cart"
        static let user = "user"
    }
    
    func saveProducts(_ items: [ProductListModel]) {
        if let encoded = try? JSONEncoder().encode(items) {
            set(encoded, forKey: Keys.productItems)
        }
    }

    func getproducts() -> [ProductListModel] {
        if let data = data(forKey: Keys.productItems),
           let decoded = try? JSONDecoder().decode([ProductListModel].self, from: data) {
            return decoded
        }
        return []
    }
    
    func saveCartItems(_ items: [ProductListModel]) {
        if let encoded = try? JSONEncoder().encode(items) {
            set(encoded, forKey: Keys.cartItems)
        }
    }

    func getCartItems() -> [ProductListModel] {
        if let data = data(forKey: Keys.cartItems),
           let decoded = try? JSONDecoder().decode([ProductListModel].self, from: data) {
            return decoded
        }
        return []
    }
    
    func isLogedIn() -> Bool{
        if let data = data(forKey:  Keys.user),
           let _ = try? JSONDecoder().decode(User.self, from: data) {
            return true
        }
        return false
    }
    
    func saveUser(user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            set(encoded, forKey: Keys.user)
        }
    }
    
    func getUser() -> User? {
        if let data = data(forKey: Keys.user),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            return decoded
        }
        return nil
    }

}
