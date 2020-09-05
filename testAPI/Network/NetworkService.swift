//
//  NetworkService.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class NetworkService {
    
    func request(httpBody : String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let token = "rkomXHX-yr-Qxsnfn2"
        let url = "https://bnet.i-partner.ru/testAPI/"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.setValue(token, forHTTPHeaderField: "token")
        
        request.httpMethod = "POST"
        request.httpBody = "\(httpBody)".data(using: .utf8)!
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
           
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
