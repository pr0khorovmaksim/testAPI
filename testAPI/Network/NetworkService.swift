//
//  NetworkService.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class NetworkService {
    
    fileprivate let constants : Constants? = Constants()
    
    func request<T>(httpBody : T, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let token = constants!.token
        let url = constants!.url
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.setValue(token, forHTTPHeaderField: "token")
        
        request.httpMethod = constants?.httpMethod
        request.httpBody = "\(httpBody)".data(using: .utf8)!
        request.addValue(constants!.mime, forHTTPHeaderField: constants!.header)
        
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
