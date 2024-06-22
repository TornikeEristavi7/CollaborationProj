//
//  AutorizationHeader.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import UIKit

class AutorizationHeader: UIView {

    private var greetingText: UILabel = {
        let label = UILabel()
        label.text = "კეთილი იყოს მობრძანება"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupheaderView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupheaderView(){
        self.addSubview(greetingText)
        self.addSubview(logo)
        
        
        NSLayoutConstraint.activate([
            
            greetingText.topAnchor.constraint(equalTo: self.topAnchor),
            greetingText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            greetingText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            logo.topAnchor.constraint(equalTo: greetingText.bottomAnchor, constant: 50),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            logo.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        
    }
}
