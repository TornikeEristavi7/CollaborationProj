//
//  ProductsList.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 20.06.24.
//

import UIKit
import Network

class ProductsListViewController: UIViewController {
    
    let tableView = UITableView()
    private let cartView = CartView()
    private let logoImageView = UIImageView()
    let logoutButton = UIButton(type: .custom)
    
    let viewModel = ProductListViewModel()
    
    private var isNetworkReachable: Bool = true
    
    private var pathMonitor: NWPathMonitor?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchProducts()
        viewModel.cartviewInfo()
        setupNetworkMonitor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLogoImageView()
        setupTabelView()
        setupLogout()
        cartView.delegate = self
        CartManager.shared.delegate = viewModel
        viewModel.output = self
    }
    
    private func setupTabelView() {
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.hidesBackButton = true
        view.addSubview(tableView)
        
        tableView.register(ProductListCell.self, forCellReuseIdentifier: "ProductListCell")
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        
        view.addSubview(cartView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
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
        
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 122),
            logoImageView.heightAnchor.constraint(equalToConstant: 103),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func setupNetworkMonitor() {
        pathMonitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor?.start(queue: queue)
        
        pathMonitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isNetworkReachable = path.status == .satisfied
                if !self!.isNetworkReachable {
                    self?.showNoInternetAlert()
                }
            }
        }
    }
    
    private func showNoInternetAlert() {
        let alert = UIAlertController(title: "No Internet Connection",
                                      message: "Please check your internet connection and try again.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupLogout(){
        let iconImage = UIImage(named: "logoutView")
        let iconButton = UIBarButtonItem(image: iconImage, style: .plain, target: self, action: #selector(iconButtonTapped))
        iconButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = iconButton
    }
    
    @objc func iconButtonTapped() {
        viewModel.logout()
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
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
    func switchController() {
        let vc = AuthorizationController()
        let navController = UINavigationController(rootViewController: vc)
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = navController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupCartView(_ total: (Int, Double)) {
        self.cartView.configure(cartAmount: total.0, total: total.1)
    }
    
}
