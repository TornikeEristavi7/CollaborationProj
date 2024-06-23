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
}

protocol ProductListModelOutput {
    func reloadData()
}



class ProductListViewModel: NSObject, ProductListViewModelType  {
    var input: ProductListModelInput { self }
    
    var output: ProductListModelOutput?
    
    var products = [ProductListModel]()
    
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
        
        
    }
    
}


extension ProductListViewModel: ProductListModelInput {
    func fetchProducts() {
        NetworkService.shared.getData(urlString: "https://dummyjson.com/products") { (res: Result<ResponseModel,Error>) in
            Task {
                self.response = try! res.get()
                self.output?.reloadData()
            }
        }
    }
}

