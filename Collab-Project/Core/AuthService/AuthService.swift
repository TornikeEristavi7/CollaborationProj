//
//  AuthService.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation

enum authError: Error {
    case userNotFound
}

extension authError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNotFound:
            return NSLocalizedString("მომხმარებლის მონაცემები არასწორია", comment: "My error")
        }
    }
}


class AuthService {
    
    private let users: [User] = [
        User(email: "Avalianitata@gmail.com", password: "123321", balance: 40000)
    ]
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            if let user = self.users.first(where: { $0.email == email && $0.password == password }) {
                completion(.success(user))
            } else {
                completion(.failure(authError.userNotFound))
            }
        }
    }
}
