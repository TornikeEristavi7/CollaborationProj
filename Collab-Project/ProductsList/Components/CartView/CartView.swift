//
//  CartView.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

protocol CartViewDelegate {
    func seeCart()
}

class CartView: UIView {
    
    var delegate: CartViewDelegate?
    
    private var cart: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bag")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var count: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var totalPrice: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var seeCart: UIButton = {
        let button = UIButton()
        button.setTitle("კალათაში გადასვლა", for: .normal)
        button.setImage(UIImage(named: "arrow-right"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .right
        let spacing: CGFloat = 5.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        seeCart.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.seeCart()
        }), for: .touchUpInside)
        
        self.backgroundColor =  UIColor(red: 68/255, green: 165/255, blue: 255/255, alpha: 1.0)
        
        let labelStack = UIStackView(arrangedSubviews: [count, totalPrice])
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        labelStack.axis = .vertical
        labelStack.distribution = .fillEqually
        labelStack.spacing = 4
        
        
        let divider = UIView()
        divider.backgroundColor = .white
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(cart)
        self.addSubview(divider)
        self.addSubview(labelStack)
        self.addSubview(seeCart)
        
        
        NSLayoutConstraint.activate([
            
            cart.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            cart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            cart.heightAnchor.constraint(equalToConstant: 24),
            cart.widthAnchor.constraint(equalToConstant: 24),
            
            divider.leadingAnchor.constraint(equalTo: cart.trailingAnchor, constant: 10),
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 24),
            divider.centerYAnchor.constraint(equalTo: cart.centerYAnchor),
            
            labelStack.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 10),
            labelStack.centerYAnchor.constraint(equalTo: cart.centerYAnchor),
            
            seeCart.leadingAnchor.constraint(equalTo: labelStack.trailingAnchor),
            seeCart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            seeCart.centerYAnchor.constraint(equalTo: cart.centerYAnchor),
            
            
        ])
        
    }
    
    func configure(cartAmount: Int, total: Double ){
        count.text = "\(cartAmount)x"
        totalPrice.text = "\(total)"
    }
    
}
