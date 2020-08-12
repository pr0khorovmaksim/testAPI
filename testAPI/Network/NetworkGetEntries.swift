//
//  NetworkGetEntries.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

class NetworkGetEntries {
    
    let networkService = NetworkService()

    func fetchEntry(urlString: String, token : String, session : String, response: @escaping (GetEntries?) -> Void) {
        networkService.requestGetEntries(urlString: urlString, token : token, session : session ) { (result) in
           
            switch result {
            case .success(let data):
                do {
                    let entry = try JSONDecoder().decode(GetEntries.self, from: data)
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
