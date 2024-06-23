//
//  ProductsList.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 20.06.24.
//

import UIKit

class ProductsList: UIViewController {
    
    let tableView = UITableView()
    private let cartView = CartView()
    
    let viewModel = ProductListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        viewModel.fetchProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabelView()
        viewModel.output = self
        
    }
    
    private func setupTabelView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.register(ProductListCell.self, forCellReuseIdentifier: "ProductListCell")
        
        tableView.separatorStyle = .none
        
        
        tableView.separatorColor = UIColor.clear
        tableView.layer.borderWidth = 1.5
        tableView.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1.0).cgColor
        
        view.addSubview(cartView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cartView.topAnchor),
            
            cartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cartView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
}


extension ProductsList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(viewModel.productList.keys)[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.productList.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(viewModel.productList.keys)[section]
        return viewModel.productList[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        
        let key = Array(viewModel.productList.keys)[indexPath.section]
        if let products = viewModel.productList[key] {
            let product = products[indexPath.row]
            cell.configure(item: product)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension ProductsList: ProductListModelOutput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
