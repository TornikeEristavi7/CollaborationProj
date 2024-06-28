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
    
    var returnButtonTappedAction: (() -> Void)?
    var dismissAction: (() -> Void)?

    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 300)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 300)
    }

    private func setupView() {
        backgroundColor = .white
        clipsToBounds = true
        
        handleView.backgroundColor = .lightGray
        handleView.layer.cornerRadius = 2
        addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        handleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        handleView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        let imageViewOfUnsuccess = UIImageView(image: UIImage(named: "imageOfUnsuccess"))
        imageViewOfUnsuccess.contentMode = .scaleAspectFit
        addSubview(imageViewOfUnsuccess)
        imageViewOfUnsuccess.translatesAutoresizingMaskIntoConstraints = false
        imageViewOfUnsuccess.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageViewOfUnsuccess.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        imageViewOfUnsuccess.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewOfUnsuccess.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        messageLabel.text = "სამწუხაროდ გადახდა ვერ მოხერხდა, სცადეთ თავიდან."
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: imageViewOfUnsuccess.bottomAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        returnButtonContainer.layer.cornerRadius = 20
        addSubview(returnButtonContainer)
        returnButtonContainer.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 0.8)
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func returnButtonTapped() {
        animateSlideUp()
        returnButtonTappedAction?()
    }
    
    func configurePopup(text: String, icon: String) {
        messageLabel.text = text
        
        removeImageViewIfExists()
        
        if let imageOfSuccess = UIImage(named: icon) {
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
        
        animateSlideUp()
    }

    private func removeImageViewIfExists() {
        for subview in subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
    
    private func animateSlideUp() {
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = UIScreen.main.bounds.height - self.frame.height
        }
    }
    
    private func animateSlideDown(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = UIScreen.main.bounds.height
        }) { _ in
            completion?()
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: UIApplication.shared.keyWindow)
        
        if gesture.state == .began {
            initialTouchPoint = touchPoint
        } else if gesture.state == .changed {
            let deltaY = touchPoint.y - initialTouchPoint.y
            if deltaY > 0 { 
                self.frame.origin.y += deltaY
                initialTouchPoint = touchPoint
            }
        } else if gesture.state == .ended || gesture.state == .cancelled {
            if self.frame.origin.y < UIScreen.main.bounds.height - self.frame.height / 2 {
                animateSlideUp()
            } else {
                animateSlideDown {
                    self.dismissAction?()
                }
            }
        }
    }
    
    func dismiss() {
        animateSlideDown {
            self.dismissAction?()
        }
    }
}
