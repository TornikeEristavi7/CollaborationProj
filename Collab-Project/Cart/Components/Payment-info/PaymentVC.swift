//
//  PaymentVC.swift
//  Collab-Project
//
//  Created by Tornike Eristavi on 17.06.24.
//
import UIKit

class PaymentVC: UIView {
    let messageLabel = UILabel()
    let returnButtonContainer = UIView()
    let returnButton = UIButton()
    let handleView = UIView()
    let imageOfUnsucces = UIImage(named: "imageOfUnsucces")
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
        
        let imageViewOfUnsucces = UIImageView(image: imageOfUnsucces)
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
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let superview = superview else { return }
        let translation = gesture.translation(in: superview)
        
        if gesture.state == .changed {
            let newY = frame.origin.y + translation.y
            if newY >= superview.frame.height - frame.height && newY <= superview.frame.height {
                frame.origin.y = newY
                gesture.setTranslation(.zero, in: superview)
            }
        } else if gesture.state == .ended {
            let velocity = gesture.velocity(in: superview)
            if translation.y > 10 || velocity.y > 500 { 
                animateSlideDown()
            } else {
                animateSlideUp()
            }
        }
    }
    
    private func animateSlideDown() {
        guard let superview = superview else { return }
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y = superview.frame.height
            superview.layoutIfNeeded()
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func animateSlideUp() {
        guard let superview = superview else { return }
        UIView.animate(withDuration: 0.5) {
            self.frame.origin.y = superview.frame.height - self.frame.height
            superview.layoutIfNeeded()
        }
    }
    
    func show() {
        guard let superview = superview else { return }
        popupTopConstraint?.constant = -frame.height
        UIView.animate(withDuration: 0.5) {
            superview.layoutIfNeeded()
        }
    }
    
    func hide() {
        popupTopConstraint?.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.superview?.layoutIfNeeded()
        }
    }
}
