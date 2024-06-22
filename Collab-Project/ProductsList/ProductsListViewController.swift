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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        
        switch indexPath.row {
        case 0:
            cell.configure(withTitle: "Samsung", stock: 36, price: 1249, imageName: "Image1")
        case 1:
            cell.configure(withTitle: "Microsoft Surface", stock: 68, price: 1499, imageName: "Image2")
        case 2:
            cell.configure(withTitle: "HP Pavilion", stock: 89, price: 1099, imageName: "Image3")
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}



