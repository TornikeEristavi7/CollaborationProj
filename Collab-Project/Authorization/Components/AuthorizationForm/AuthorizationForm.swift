//
//  AuthorizationForm.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

protocol AuthorizationFormDelegate {
    func submitForm(email: String, password: String)
}

class AuthorizationForm: UIView {
    
    var delegate: AuthorizationFormDelegate?
    
    private var emailField: UITextField = {
        let textField = FieldWithPaddings()
        textField.placeholder = "ელ-ფოსტა"
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(red: 160/255, green: 163/255, blue: 189/255, alpha: 1.0)
        textField.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1.0).cgColor
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1.0)
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private var passwordField: UITextField = {
        let textField = FieldWithPaddings()
        textField.placeholder = "პაროლი"
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(red: 160/255, green: 163/255, blue: 189/255, alpha: 1.0)
        textField.layer.borderColor = UIColor(red: 217/255, green: 219/255, blue: 233/255, alpha: 1.0).cgColor
        textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textField.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1.0)
        textField.layer.borderWidth = 2.0
        return textField
    }()
    
    private var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 68/255, green: 165/255, blue: 255/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitle("შესვლა", for: .normal)
        button.titleLabel?.text = button.titleLabel?.text?.uppercased()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupFormView()
        submitButton.addAction(UIAction(handler: { [weak self] _ in
            self?.submit()
        }), for: .touchUpInside)
        
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            submitButton.setTitle("Loading...", for: .normal)
            submitButton.isEnabled = false
            submitButton.backgroundColor = .systemGray3
        } else {
            submitButton.setTitle("შესვლა", for: .normal)
            submitButton.isEnabled = true
            submitButton.backgroundColor = UIColor(red: 68/255, green: 165/255, blue: 255/255, alpha: 1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFormView() {
        
        let formStack = UIStackView(arrangedSubviews: [emailField, passwordField, submitButton])
        
        formStack.axis = .vertical
        formStack.distribution = .fillEqually
        formStack.spacing = 20
        
        formStack.addArrangedSubview(submitButton)
        
        self.addSubview(formStack)
        formStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            formStack.topAnchor.constraint(equalTo: self.topAnchor),
            formStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            formStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            formStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    
    private func submit() {
        self.delegate?.submitForm(email: emailField.text ?? "", password: passwordField.text ?? "")
    }
    
}
