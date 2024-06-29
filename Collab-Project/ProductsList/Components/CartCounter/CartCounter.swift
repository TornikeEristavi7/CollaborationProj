//
//  CartCounter.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

class CartCounter: UIView {
    
    var product: ProductListModel?
    
    var count: Int = 0 {
        didSet {
            counterLabel.text = "\(count)"
        }
    }
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(minusButton)
        addSubview(counterLabel)
        addSubview(plusButton)
        
        minusButton.addAction(UIAction(handler: { [weak self] _ in
            
            if self!.count > 0 {
                self?.count -= 1
                CartManager.shared.removeFromCart(item: self!.product!)
                ProductsManager.shared.removeFromCart(item: self!.product!)
            }
        }), for: .touchUpInside)
        
        plusButton.addAction(UIAction(handler: { [weak self] _ in
            
            if self!.count < self!.product!.product.stock {
                self?.count += 1
                CartManager.shared.addToCart(item: self!.product!)
                ProductsManager.shared.addToCart(item: self!.product!)
            }
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.heightAnchor.constraint(equalToConstant: 24),
            
            counterLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 10),
            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            counterLabel.widthAnchor.constraint(equalToConstant: 10),
            
            plusButton.leadingAnchor.constraint(equalTo: counterLabel.trailingAnchor, constant: 10),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        counterLabel.text = "\(count)"
    }
    
}
