//
//  PaymentInfoView.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//
import UIKit

class PaymentInfoView: UIView {
    
    let messageLabel = UILabel()
    let returnButtonContainer = UIView()
    let returnButton = UIButton()
    let handleView = UIView()
    var popupTopConstraint: NSLayoutConstraint?
    
    var returnButtonTappedAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupGestureRecognizers()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        handleView.backgroundColor = .lightGray
        handleView.layer.cornerRadius = 2
        addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        handleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        handleView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        let imageViewOfUnsucces = UIImageView(image: UIImage(named: "imageOfUnsuccess"))
        imageViewOfUnsucces.contentMode = .scaleAspectFit
        addSubview(imageViewOfUnsucces)
        imageViewOfUnsucces.translatesAutoresizingMaskIntoConstraints = false
        imageViewOfUnsucces.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageViewOfUnsucces.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        imageViewOfUnsucces.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewOfUnsucces.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        messageLabel.text = "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან."
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: imageViewOfUnsucces.bottomAnchor, constant: 8).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        returnButtonContainer.backgroundColor = .systemTeal
        returnButtonContainer.layer.cornerRadius = 20
        addSubview(returnButtonContainer)
        returnButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        returnButtonContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        returnButtonContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        returnButtonContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        returnButtonContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        returnButton.setTitle("უკან დაბრუნება", for: .normal)
        returnButton.setTitleColor(.white, for: .normal)
        returnButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        returnButton.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        returnButtonContainer.addSubview(returnButton)
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        returnButton.centerXAnchor.constraint(equalTo: returnButtonContainer.centerXAnchor).isActive = true
        returnButton.centerYAnchor.constraint(equalTo: returnButtonContainer.centerYAnchor).isActive = true
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupGestureRecognizers() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func returnButtonTapped() {
        returnButtonTappedAction?()
    }
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        self.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        if sender.state == .ended {
            if self.frame.origin.y < UIScreen.main.bounds.height * 0.3 {
                UIView.animate(withDuration: 0.3) {
                    self.center.y = self.frame.height / 2
                }
            } else {
                removeFromSuperview()
            }
        }
    }
    
    func showSuccessMessage() {
        messageLabel.text = "გადახდა წარმატებით შესრულდა! გმადლობთ რომ სარგებლობთ ჩვენი მომსახურეობით!"
        messageLabel.textColor = .green
        
        removeImageViewIfExists()
        
        if let imageOfSuccess = UIImage(named: "imageOfSuccess") {
            let imageViewOfSuccess = UIImageView(image: imageOfSuccess)
            imageViewOfSuccess.contentMode = .scaleAspectFit
            addSubview(imageViewOfSuccess)
            imageViewOfSuccess.translatesAutoresizingMaskIntoConstraints = false
            imageViewOfSuccess.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            imageViewOfSuccess.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
            imageViewOfSuccess.widthAnchor.constraint(equalToConstant: 100).isActive = true
            imageViewOfSuccess.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.topAnchor.constraint(equalTo: imageViewOfSuccess.bottomAnchor, constant: 20).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        }
        
        CartManager.shared.emtifyCart()
        ProductsManager.shared.clearCart()
    }
    
    func showUnsuccessMessage() {
        messageLabel.text = "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან."
        messageLabel.textColor = .red
        
        removeImageViewIfExists()
        
        if let imageOfUnsuccess = UIImage(named: "imageOfUnsuccess") {
            let imageViewOfUnsuccess = UIImageView(image: imageOfUnsuccess)
            imageViewOfUnsuccess.contentMode = .scaleAspectFit
            addSubview(imageViewOfUnsuccess)
            imageViewOfUnsuccess.translatesAutoresizingMaskIntoConstraints = false
            imageViewOfUnsuccess.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            imageViewOfUnsuccess.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
            imageViewOfUnsuccess.widthAnchor.constraint(equalToConstant: 100).isActive = true
            imageViewOfUnsuccess.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.topAnchor.constraint(equalTo: imageViewOfUnsuccess.bottomAnchor, constant: 20).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        }
    }
    
    private func removeImageViewIfExists() {
        for subview in subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
}
