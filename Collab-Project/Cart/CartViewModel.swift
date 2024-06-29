//
//  CartViewModel.swift
//  Collab-Project
//
//  Created by Tatarella on 29.06.24.
//

import Foundation

protocol CartViewModelType {
    var input: CartViewModelInput { get }
    var output: CartViewModelOutput? { get }
}

protocol CartViewModelInput {
    func fetchData()
    func payment()
    func processPayment(amount: Double)
}

protocol CartViewModelOutput {
    func reloadData(balance: Double, total: Double)
    func updateCart(totalAmount: Double, balance: Double)
}

class CartViewModel: NSObject, CartViewModelType {
    
    var input: CartViewModelInput { self }
    var output: CartViewModelOutput?
    
    var cartData = [ProductListModel]()
    var balance: Double?
    
}

extension CartViewModel: CartViewModelInput{
    func processPayment(amount: Double) {
        CartManager.shared.emtifyCart()
        ProductsManager.shared.clearCart()
        guard var user = UserDefaults.standard.getUser() else { return }
        user.balance -= amount
        UserDefaults.standard.saveUser(user: user)
        fetchData()
    }
    
    func payment() {
        self.output?.updateCart(totalAmount: CartManager.shared.cartInfo().total, balance: balance ?? 0 )
    }
    
    func fetchData() {
        cartData = CartManager.shared.getCartItems()
        guard let user = UserDefaults.standard.getUser() else { return }
        balance = user.balance.rounded(toPlaces: 2)
        self.output?.reloadData(balance: balance ?? 0, total: CartManager.shared.cartInfo().total)
    }
}


