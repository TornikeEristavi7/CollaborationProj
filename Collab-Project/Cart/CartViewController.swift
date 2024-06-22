//
//  CartViewController.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit


class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var products: [ProductModel] = []
    let tableView = UITableView()
    let bottomView = UIView()
    let payButton = UIButton()
    let totalLabel = UILabel()
    let totalPriceLabel = UILabel()
    let idLabel = UILabel()
    let balanceTitleLabel = UILabel()
    let feeTitleLabel = UILabel()
    let deliveryTitleLabel = UILabel()
    let balancePriceLabel = UILabel()
    let feePriceLabel = UILabel()
    let deliveryPriceLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 246/255, alpha: 1.0)
        
        title = "გადახდის გვერდი"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartProductCell.self, forCellReuseIdentifier: "CartProductCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        setupBottomView()
        fetchData()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }
    
    private func setupBottomView() {
        let lightGrayColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        bottomView.backgroundColor = lightGrayColor
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        idLabel.text = "Balance:"
        idLabel.font = UIFont.boldSystemFont(ofSize: 14)
        idLabel.textColor = .black
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(idLabel)
        
        balancePriceLabel.text = "47999$"
        balancePriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        balancePriceLabel.textColor = .black
        balancePriceLabel.textAlignment = .right
        balancePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(balancePriceLabel)
        
        balanceTitleLabel.text = "Total Price:"
        balanceTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        balanceTitleLabel.textColor = .black
        balanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(balanceTitleLabel)
        
        totalPriceLabel.text = "3997$"
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        totalPriceLabel.textColor = .black
        totalPriceLabel.textAlignment = .right
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(totalPriceLabel)
        
        feeTitleLabel.text = "Fee:"
        feeTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        feeTitleLabel.textColor = .black
        feeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(feeTitleLabel)
        
        feePriceLabel.text = "39.97$"
        feePriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        feePriceLabel.textColor = .black
        feePriceLabel.textAlignment = .right
        feePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(feePriceLabel)
        
        deliveryTitleLabel.text = "Delivery:"
        deliveryTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        deliveryTitleLabel.textColor = .black
        deliveryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(deliveryTitleLabel)
        
        deliveryPriceLabel.text = "50$"
        deliveryPriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        deliveryPriceLabel.textColor = .black
        deliveryPriceLabel.textAlignment = .right
        deliveryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(deliveryPriceLabel)
        
        let totalTitleLabel = UILabel()
        totalTitleLabel.text = "TOTAL:"
        totalTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalTitleLabel.textColor = .black
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(totalTitleLabel)
        
        let totalAmountLabel = UILabel()
        totalAmountLabel.text = "4086.97$"
        totalAmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalAmountLabel.textColor = .black
        totalAmountLabel.textAlignment = .right
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(totalAmountLabel)
        
        payButton.setTitle("გადახდა", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
        payButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 0.8)
        payButton.layer.cornerRadius = 12
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(payButton)
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            idLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            balancePriceLabel.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            balancePriceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            balanceTitleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: balanceTitleLabel.centerYAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            feeTitleLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 10),
            feeTitleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            feePriceLabel.centerYAnchor.constraint(equalTo: feeTitleLabel.centerYAnchor),
            feePriceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            deliveryTitleLabel.topAnchor.constraint(equalTo: feeTitleLabel.bottomAnchor, constant: 10),
            deliveryTitleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            deliveryPriceLabel.centerYAnchor.constraint(equalTo: deliveryTitleLabel.centerYAnchor),
            deliveryPriceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            totalTitleLabel.topAnchor.constraint(equalTo: deliveryTitleLabel.bottomAnchor, constant: 10),
            totalTitleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalTitleLabel.centerYAnchor),
            totalAmountLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            payButton.topAnchor.constraint(equalTo: totalTitleLabel.bottomAnchor, constant: 20),
            payButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 60),
            payButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -20)
        ])
    }

    @objc private func payButtonTapped() {
        
        // TODO: სწორ კონტროლერზე გადავიდეს
//        let temporaryVC = TemporaryVC()
//        navigationController?.pushViewController(temporaryVC, animated: true)
    }
    
    func fetchData() {
        products = [ProductModel(id: 2, title: "dlkdmf", price: 2.2, category: "grocery", stock: 4, thumbnail: "https://picsum.photos/id/870/200/300?grayscale&blur=2")]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as? CartProductCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(with: product.title, description: String(product.stock), price: product.price, imageName: product.thumbnail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
