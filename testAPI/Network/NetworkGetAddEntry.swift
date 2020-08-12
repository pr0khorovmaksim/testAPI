//
//  NetworkGetAddEntry.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

class NetworkGetAddEntry {
    
    let networkService = NetworkService()
    
    func fetchAddEntry(urlString: String, token : String, session : String, body : String, response: @escaping (GetAddEntry?) -> Void) {
        networkService.requestAddEntry(urlString: urlString, token : token, session : session, body : body ) { (result) in
           
            switch result {
            case .success(let data):
                do {
                    let entry = try JSONDecoder().decode(GetAddEntry.self, from: data)
                    response(entry)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
