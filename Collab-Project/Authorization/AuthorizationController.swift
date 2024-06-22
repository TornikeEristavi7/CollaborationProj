//
//  AuthorizationController.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

class AuthorizationController: UIViewController {
    
    private let viewModel = AuthorizationViewModel()
    
    private let authorizationHeader = AutorizationHeader()
    private let authorizationForm = AuthorizationForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAuthorizationView()
        setupBindings()
        
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
                    self?.showAlert(title: "ავტორიზაცია", message: message)
                   //TODO: გადავიდეს ლისტინგის კონტროლერზე
                case false:
                    self?.showAlert(title: "დაფიქსირდა შეცდომა", message: message)
                }
            }
        }
    }
}
