//
//  CartViewController.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//
import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var products: [ProductListModel] = []
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

    var feePrice: Double = 39.97
    var deliveryPrice: Double = 50.0

    lazy var popupView: PaymentInfoView = {
        let view = PaymentInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var popupBottomConstraint: NSLayoutConstraint?

    var balance: Double = 0 {
        didSet {
            balancePriceLabel.text = "\(balance)$"
            updateTotalAmount()
        }
    }

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
        setupPopupView()

        fetchData()
        
        fetchUser()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }

    private func fetchUser(){
        guard let user = UserDefaults.standard.data(forKey: "user") else { return }
        do {
            let decoder = JSONDecoder()
            let person = try decoder.decode(User.self, from: user)
            balance = Double(person.balance)
        } catch { }
        
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

        balancePriceLabel.text = "\(balance)$"
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

        totalPriceLabel.text = "\(CartManager.shared.cartInfo().total)"
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

        feePriceLabel.text = "\(feePrice)$"
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

        deliveryPriceLabel.text = "\(deliveryPrice)$"
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
        totalAmountLabel.text = "\(CartManager.shared.cartInfo().total + feePrice + deliveryPrice)"
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

    private func setupPopupView() {
        view.addSubview(popupView)
        popupView.returnButtonTappedAction = { [weak self] in
            self?.hidePopup()
        }
        popupView.isHidden = true

        popupBottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: popupView.frame.height)
        popupBottomConstraint?.isActive = true
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
    }

    @objc private func payButtonTapped() {
        let subtotal = CartManager.shared.cartInfo().total
        let total = subtotal + feePrice + deliveryPrice

        if total <= balance, products.count > 0  {
            // ბალანსი გავუტოლოთ ახალ ბალანსს(გამოკლებულს) და იუზერდეფოლტებიც დაისეტოს
            showPopup()
            popupView.configurePopup(text: "გადახდა წარმატებით შესრულდა! გმადლობთ რომ სარგებლობთ ჩვენი მომსახურეობით!", icon: "imageOfSuccess")
            CartManager.shared.emtifyCart()
            ProductsManager.shared.clearCart()
            products = CartManager.shared.getCartItems()
            self.tableView.reloadData()
            
        } else {
            popupView.configurePopup(text: "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან.", icon: "imageOfUnsuccess")
            showPopup()
        }
    }

    private func showPopup() {
        view.layoutIfNeeded()
        popupView.isHidden = false
        popupBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    private func hidePopup() {
        popupBottomConstraint?.constant = popupView.frame.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    func fetchData() {
        products = CartManager.shared.getCartItems()
        tableView.reloadData()

        updateTotalAmount()
    }

    private func updateTotalAmount() {
        let subtotal = CartManager.shared.cartInfo().total
        let total = subtotal + feePrice + deliveryPrice
        totalPriceLabel.text = "\(total)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as? CartProductCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(with: product.product.title, description: String(product.product.stock), price: product.product.price, imageName: product.product.thumbnail)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
