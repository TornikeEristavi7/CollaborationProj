//
//  ProductsList.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 20.06.24.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    let tableView = UITableView()
    private let cartView = CartView()
    private let logoImageView = UIImageView()
    let logoutButton = UIButton(type: .custom)
    
    let viewModel = ProductListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchProducts()
        viewModel.cartviewInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTabelView()
        
        cartView.delegate = self
        CartManager.shared.delegate = viewModel

        viewModel.output = self
        
        setupLogoImageView()
        setupLogoutButton()
        
    }
    
    private func setupTabelView() {
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.hidesBackButton = true
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 184),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cartView.topAnchor),
            
            cartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cartView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLogoImageView() {
        if let logoImage = UIImage(named: "logo") {
            logoImageView.image = logoImage
        } else {
            print("ფოტო ვერ ვიპოვეთ.სცადეთ თავიდან")
        }
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 16
        logoImageView.layer.maskedCorners = [.layerMinXMinYCorner]
//        logoImageView.alpha = 0.8 ეს გავთიშოთ რომ ლოგო დერმკრთალი არიყოს ოკ დოკ?
        
        view.addSubview(logoImageView)
        
//        ზომა თუარ დაგევასათ შეცვალეთ :დ
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 122),
            logoImageView.heightAnchor.constraint(equalToConstant: 103),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 133)
        ])
    }
    
    private func setupLogoutButton() {
        guard let logoutImage = UIImage(named: "logoutView") else {
            print("ფოტო ვერ ვიპოვეთ.სცადეთ თავიდან")
            return
        }
        
        logoutButton.setImage(logoutImage, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 315)
        ])
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    @objc private func logoutButtonTapped() {

        print("Logout button tapped")
        
    }
    
    @objc func userDefaultsDidChange(_ notification: Notification) {
        let total = CartManager.shared.cartInfo()
        self.cartView.configure(cartAmount: total.amount, total: total.total)
        
    }
}

extension ProductsListViewController: CartViewDelegate {
    func seeCart() {
        let vc = CartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
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

extension ProductsListViewController: ProductListModelOutput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupCartView(_ total: (Int, Double)) {
        self.cartView.configure(cartAmount: total.0, total: total.1)
    }
    
}
