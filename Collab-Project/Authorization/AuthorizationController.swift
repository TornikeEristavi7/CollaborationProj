//
//  AuthorizationController.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit
import Network

class AuthorizationController: UIViewController {
    
    private let viewModel = AuthorizationViewModel()
    
    private let authorizationHeader = AutorizationHeader()
    private let authorizationForm = AuthorizationForm()
    
    private var isNetworkReachable: Bool = true
    
    private var pathMonitor: NWPathMonitor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAuthorizationView()
        setupBindings()
        setupNetworkMonitor()
        
    }
    
    private func setupAuthorizationView() {
        view.addSubview(authorizationHeader)
        view.addSubview(authorizationForm)
        
        authorizationHeader.translatesAutoresizingMaskIntoConstraints = false
        authorizationForm.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorizationHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            authorizationHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorizationHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            authorizationForm.topAnchor.constraint(equalTo: authorizationHeader.bottomAnchor, constant: 40),
            authorizationForm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorizationForm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authorizationForm.heightAnchor.constraint(equalToConstant: 210),
            
        ])
    }
    
    
    private func setupBindings() {
        authorizationForm.delegate = self
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension AuthorizationController: AuthorizationFormDelegate {
    func submitForm(email: String, password: String) {
        authorizationForm.setLoading(true)
        viewModel.login(email: email, password: password) { [weak self] status, message in
            DispatchQueue.main.async {
                self?.authorizationForm.setLoading(false)
                switch status {
                case true:
                    let vc = ProductsListViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                case false:
                    self?.showAlert(title: "დაფიქსირდა შეცდომა", message: message)
                }
            }
        }
    }
}
