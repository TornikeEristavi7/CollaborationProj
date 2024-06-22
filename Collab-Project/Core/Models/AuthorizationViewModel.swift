//
//  AuthorizationViewModel.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation

class AuthorizationViewModel {
    
    let authService = AuthService()
    var user: User?
    
    func login(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        
        guard !email.isEmpty && !password.isEmpty else {
            completion(false, "გთხოვთ შეავსოთ ყველა ველი")
            return
        }
        
        guard email.isValidEmail() else {
            completion(false, "ელ-ფოსტის ფორმატი არასწორია")
            return
        }
        
        authService.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.user = user
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(user)
                    UserDefaults.standard.set(data, forKey: "user")
                } catch {
                    print("დაფიქსირდა შეცდომა!")
                }
                completion(true, "ავტორიზაცია")
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
}
