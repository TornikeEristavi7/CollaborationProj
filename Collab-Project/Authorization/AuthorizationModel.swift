//
//  AuthorizationModel.swift
//  Collab-Project
//
//  Created by Tatarella on 22.06.24.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String
    var balance: Double
}
