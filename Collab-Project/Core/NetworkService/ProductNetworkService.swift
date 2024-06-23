//
//  ProductNetworkService.swift
//  Collab-Project
//
//  Created by gvanca koxreidze on 15.06.24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    func getData<T: Codable>(urlString: String, completion: @escaping (Result<T,Error>) -> (Void)) {
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("wrong Response Code")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("wrong Response code")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(object))
                }
                
            } catch {
                print("decoding error")
            }
        }.resume()
        
    }
}
