//
//  ViewController.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 22.06.24.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    let showPopupButton = UIButton()
    let newButton = UIButton()
    let popupView = PaymentInfoView()
    var popupTopConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupImage()
        setupShowPopupButton()
        setupNewButton()
        setupPopupView()
    }

    private func setupImage() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        imageView.load(from: URL(string: "https://picsum.photos/id/870/200/300?grayscale&blur=2")!)
    }

    private func setupShowPopupButton() {
        showPopupButton.setTitle("გადახდა", for: .normal)
        showPopupButton.setTitleColor(.white, for: .normal)
        showPopupButton.backgroundColor = .blue
        showPopupButton.layer.cornerRadius = 8
        showPopupButton.addTarget(self, action: #selector(showPopupButtonTapped), for: .touchUpInside)
        view.addSubview(showPopupButton)

        showPopupButton.translatesAutoresizingMaskIntoConstraints = false
        showPopupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showPopupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        showPopupButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        showPopupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupNewButton() {
        newButton.setTitle("გადასვლა 2", for: .normal)
        newButton.setTitleColor(.white, for: .normal)
        newButton.backgroundColor = .red
        newButton.layer.cornerRadius = 8
        newButton.addTarget(self, action: #selector(newButtonTapped), for: .touchUpInside)
        view.addSubview(newButton)

        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 275).isActive = true
        newButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        newButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupPopupView() {
        view.addSubview(popupView)
        popupView.returnButtonTappedAction = { [weak self] in
            self?.hidePopup()
        }
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupTopConstraint = popupView.topAnchor.constraint(equalTo: view.bottomAnchor)
        popupTopConstraint?.isActive = true
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    }

    @objc private func showPopupButtonTapped() {
        showPopup()
    }

    @objc private func newButtonTapped() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }

    private func showPopup() {
        view.layoutIfNeeded()
        popupTopConstraint?.constant = -popupView.frame.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    private func hidePopup() {
        popupTopConstraint?.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

