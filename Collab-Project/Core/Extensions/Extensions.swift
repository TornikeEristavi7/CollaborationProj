//
//  Extensions.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation
import UIKit


extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//ამოწმებს ტექტსი იმეილის ფორმატის არის თუ არა
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

//ამოწმებს ფორმის ინფუთი ცარიელია თუ არა
extension UITextField {
    var isEmpty: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }
}

// Double ტიპის ცვლადს ამრგვალებს 
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
