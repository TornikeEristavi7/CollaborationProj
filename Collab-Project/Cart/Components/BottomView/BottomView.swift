//
//  BottomView.swift
//  Collab-Project
//
//  Created by Tatarella on 29.06.24.
//

import UIKit

protocol BottomViewDelegate {
    func paymentButtonClicked()
}

class BottomView: UIView {
    
    var delegate: BottomViewDelegate?
    
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
    let totalTitleLabel = UILabel()
    let totalAmountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(balance: Double, fee: Double, deliveryPrice: Double, total: Double){
        balancePriceLabel.text = "\(balance)$"
        totalPriceLabel.text = "\(total)"
        feePriceLabel.text = "\(fee)$"
        deliveryPriceLabel.text = "\(deliveryPrice)$"
        let sum = total + fee + deliveryPrice
        totalAmountLabel.text = "\(sum.rounded(toPlaces: 2))"
    }
    
    private func setupView(){
        idLabel.text = "Balance:"
        idLabel.font = UIFont.boldSystemFont(ofSize: 14)
        idLabel.textColor = .black
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(idLabel)
        
        balancePriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        balancePriceLabel.textColor = .black
        balancePriceLabel.textAlignment = .right
        balancePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(balancePriceLabel)
        
        balanceTitleLabel.text = "Total Price:"
        balanceTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        balanceTitleLabel.textColor = .black
        balanceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(balanceTitleLabel)
        
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        totalPriceLabel.textColor = .black
        totalPriceLabel.textAlignment = .right
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalPriceLabel)
        
        feeTitleLabel.text = "Fee:"
        feeTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        feeTitleLabel.textColor = .black
        feeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(feeTitleLabel)
        
        feePriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        feePriceLabel.textColor = .black
        feePriceLabel.textAlignment = .right
        feePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(feePriceLabel)
        
        deliveryTitleLabel.text = "Delivery:"
        deliveryTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        deliveryTitleLabel.textColor = .black
        deliveryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deliveryTitleLabel)
        
        deliveryPriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        deliveryPriceLabel.textColor = .black
        deliveryPriceLabel.textAlignment = .right
        deliveryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deliveryPriceLabel)
        
        totalTitleLabel.text = "TOTAL:"
        totalTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalTitleLabel.textColor = .black
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalTitleLabel)
        
        totalAmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        totalAmountLabel.textColor = .black
        totalAmountLabel.textAlignment = .right
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(totalAmountLabel)
        
        payButton.setTitle("გადახდა", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
        payButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 0.8)
        payButton.layer.cornerRadius = 12
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(payButton)
        
        NSLayoutConstraint.activate([
            
            idLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            balancePriceLabel.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            balancePriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            balanceTitleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: balanceTitleLabel.centerYAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            feeTitleLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 10),
            feeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            feePriceLabel.centerYAnchor.constraint(equalTo: feeTitleLabel.centerYAnchor),
            feePriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            deliveryTitleLabel.topAnchor.constraint(equalTo: feeTitleLabel.bottomAnchor, constant: 10),
            deliveryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            deliveryPriceLabel.centerYAnchor.constraint(equalTo: deliveryTitleLabel.centerYAnchor),
            deliveryPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            totalTitleLabel.topAnchor.constraint(equalTo: deliveryTitleLabel.bottomAnchor, constant: 10),
            totalTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalTitleLabel.centerYAnchor),
            totalAmountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            payButton.topAnchor.constraint(equalTo: totalTitleLabel.bottomAnchor, constant: 20),
            payButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 60),
            payButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func payButtonTapped() {
        self.delegate?.paymentButtonClicked()
    }

}
