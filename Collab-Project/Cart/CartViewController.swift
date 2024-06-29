//
//  CartViewController.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//
import UIKit
import Network

class CartViewController: UIViewController {
    
    var viewModel = CartViewModel()
    
    let bottomView = BottomView()
    let tableView = UITableView()
    
    var feePrice: Double = 39.97
    var deliveryPrice: Double = 50.0
    
    lazy var popupView: PaymentInfoView = {
        let view = PaymentInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var popupBottomConstraint: NSLayoutConstraint?
    
    private var isNetworkReachable: Bool = true
    
    private var pathMonitor: NWPathMonitor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 246/255, alpha: 1.0)
        title = "გადახდის გვერდი"
        
        
        setupTableView()
        setupPopupView()
        setupNetworkMonitor()
        
        viewModel.output = self
        viewModel.fetchData()
        bottomView.delegate = self
    }
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartProductCell.self, forCellReuseIdentifier: "CartProductCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        setupBottomView()
        
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
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
}

extension CartViewController: CartViewModelOutput {
    func updateCart(totalAmount: Double, balance: Double) {
        let total = totalAmount + feePrice + deliveryPrice
        if total <= balance {
            viewModel.processPayment(amount: total)
            showPopup()
            popupView.configurePopup(text: "გადახდა წარმატებით შესრულდა!", icon: "imageOfSuccess")
        } else {
            popupView.configurePopup(text: "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან.", icon: "imageOfUnsuccess")
            showPopup()
        }
    }
    
    func reloadData(balance: Double, total: Double) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        if total > 0 {
            bottomView.configure(balance: balance, fee: feePrice, deliveryPrice: deliveryPrice, total: total)
        } else {
            bottomView.configure(balance: balance, fee: 0, deliveryPrice: 0, total: 0)
        }
    }
}

extension CartViewController: BottomViewDelegate {
    func paymentButtonClicked() {
        viewModel.payment()
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as? CartProductCell else {
            return UITableViewCell()
        }
        let currProduct = viewModel.cartData[indexPath.row]
        cell.configure(with: currProduct.product.title, description: String(currProduct.count), price: currProduct.product.price, imageName: currProduct.product.thumbnail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
