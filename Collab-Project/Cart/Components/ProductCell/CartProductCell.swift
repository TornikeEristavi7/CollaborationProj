//
//  CartProductCell.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

class CartProductCell: UITableViewCell {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let productImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 70),
            productImageView.heightAnchor.constraint(equalToConstant: 70),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.textColor = .gray
        priceLabel.textAlignment = .right
        
        productImageView.contentMode = .scaleAspectFit
    }
    
    func configure(with title: String, description: String, price: Double, imageName: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        
        if let image = UIImage(named: imageName) {
            productImageView.image = image
        } else {
            if let imageURL = URL(string: imageName) {
                productImageView.load(from: imageURL)
            } else {
                productImageView.image = UIImage(named: "placeholder_image")
            }
        }
        
        priceLabel.text = String(format: "%.2f$", price)
    }
}

