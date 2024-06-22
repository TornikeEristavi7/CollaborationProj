//
//  ProductsList.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 20.06.24.
//

import UIKit

class ProductsList: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        
        tableView.separatorStyle = .none
        
        
        tableView.separatorColor = UIColor.clear
        tableView.layer.borderWidth = 1.5
        tableView.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1.0).cgColor
    }
}


extension ProductsList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
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





class CustomTableViewCell: UITableViewCell {
    
    let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1.0).cgColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = Typography.labelFont
        titleLabel.textColor = Typography.labelTextColor
        titleLabel.textAlignment = Typography.labelTextAlignment
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let stockLabel: UILabel = {
        let stockLabel = UILabel()
        stockLabel.font = Typography.labelFont
        stockLabel.textColor = Typography.labelTextColor
        stockLabel.textAlignment = Typography.labelTextAlignment
        stockLabel.translatesAutoresizingMaskIntoConstraints = false
        return stockLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = Typography.labelFont
        priceLabel.textColor = Typography.labelTextColor
        priceLabel.textAlignment = Typography.labelTextAlignment
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.labelFont
        label.textColor = Typography.labelTextColor
        label.textAlignment = .center
        label.text = "\(0)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        minusButtonTapped()
        addButtonTapped()
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(contentContainerView)
        
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(stockLabel)
        contentContainerView.addSubview(priceLabel)
        contentContainerView.addSubview(productImageView)
        contentContainerView.addSubview(addButton)
        contentContainerView.addSubview(minusButton)
        contentContainerView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contentContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contentContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            contentContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            productImageView.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor),
            productImageView.leftAnchor.constraint(equalTo: contentContainerView.leftAnchor, constant: 12),
            productImageView.widthAnchor.constraint(equalToConstant: 116),
            productImageView.heightAnchor.constraint(equalToConstant: 115),
            
            titleLabel.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            
            stockLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stockLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            
            priceLabel.topAnchor.constraint(equalTo: stockLabel.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            
            
            minusButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            minusButton.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 130),
            
            addButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 40),
            addButton.leftAnchor.constraint(equalTo: minusButton.rightAnchor, constant: 29),
            
            countLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            countLabel.leftAnchor.constraint(equalTo: contentContainerView.leftAnchor, constant: 293),
        ])
    }
    
    @objc private func addButtonTapped() {
        print("add Button tapped")
        
    }
    
    @objc private func minusButtonTapped() {
        
    }
    
    func configure(withTitle title: String, stock: Int, price: Int, imageName: String) {
        titleLabel.text = title
        stockLabel.text = "Stock: \(stock)"
        priceLabel.text = "Price: \(price)"
        productImageView.image = UIImage(named: imageName)
    }
    
    struct Typography {
        static let labelFont: UIFont = {
            if let font = UIFont(name: "Inter", size: 12) {
                return UIFontMetrics.default.scaledFont(for: font)
            }
            return UIFont.systemFont(ofSize: 12, weight: .bold)
        }()
        
        static let labelTextColor: UIColor = .black
        static let labelTextAlignment: NSTextAlignment = .left
    }
}
