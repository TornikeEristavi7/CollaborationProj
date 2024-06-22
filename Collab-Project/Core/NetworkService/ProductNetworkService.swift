//
//  ProductNetworkService.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 15.06.24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    func fetchProducts(completion: @escaping (ResponseModel?, Error?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }

            do {
                let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
