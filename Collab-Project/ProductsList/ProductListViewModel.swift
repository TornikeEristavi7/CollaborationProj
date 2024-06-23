//
//  ProductListViewModel.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 23.06.24.
//

import Foundation

protocol ProductListViewModelType {
    var input: ProductListModelInput { get }
    var output: ProductListModelOutput? { get }
}

protocol ProductListModelInput {
    func fetchProducts()
    func cartviewInfo()
}

protocol ProductListModelOutput {
    func reloadData()
    func setupCartView(_ total: (Int, Double))
}



class ProductListViewModel: NSObject, ProductListViewModelType  {
    var input: ProductListModelInput { self }
    
    var output: ProductListModelOutput?
    
    var products = [ProductListModel]()
    
    var productList = [String: [ProductListModel]]()
    
    private var response: ResponseModel? {
        didSet {
            updateDataForTableView()
        }
    }
    
    
    private func updateDataForTableView() {
        guard let response = response else {
            products = []
            return
        }
        
        for product in response.products {
            products.append(ProductListModel(product: product, count: 0))
        }
        
        UserDefaults.standard.saveProducts(products)
        
        self.productList = Dictionary(grouping: products, by: {
            $0.product.category
        })
        
    }
    
}


extension ProductListViewModel: ProductListModelInput {
    func cartviewInfo() {
        let total = CartManager.shared.cartInfo()
        self.output?.setupCartView(total)
    }
    
    func fetchProducts() {
        
        products = UserDefaults.standard.getproducts()
        
        self.productList = Dictionary(grouping: products, by: {
            $0.product.category
        })
        
        self.output?.reloadData()
        if products.count == 0 {
            NetworkService.shared.getData(urlString: "https://dummyjson.com/products") { (res: Result<ResponseModel,Error>) in
                Task {
                    self.response = try! res.get()
                    self.output?.reloadData()
                }
            }
        }
    }
}

extension ProductListViewModel: CartManagerDelegate {
    func cartDidUpdate() {
        let total = CartManager.shared.cartInfo()
        self.output?.setupCartView(total)
    }
}


