//
//  NetworkService.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

class NetworkService {
    
    func requestNewSession(urlString: String, token : String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: urlString)!)

        request.setValue(token, forHTTPHeaderField: "token")
        
        request.httpMethod = "POST"
        request.httpBody = "a=new_session".data(using: .utf8)!
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
    
    
    func requestGetEntries(urlString: String, token : String, session: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: urlString)!)
        
        request.setValue(token, forHTTPHeaderField: "token")
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "a=get_entries&session=\(session)".data(using: .utf8)
        request.httpBody = body

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
    
    func requestAddEntry(urlString: String, token : String, session: String, body : String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: urlString)!)
        
        request.setValue(token, forHTTPHeaderField: "token")
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

       let body = "a=add_entry&session=\(session)&body=\(body)".data(using: .utf8)
       request.httpBody = body
        
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
