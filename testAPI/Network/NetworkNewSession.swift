//
//  NetworkDataFetcher.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

class NetworkNewSession {
    
    let networkService = NetworkService()
    
    func fetchSession(urlString: String, token : String, response: @escaping (GetNewSession?) -> Void) {
        networkService.requestNewSession(urlString: urlString, token : token ) { (result) in
           
            switch result {
            case .success(let data):
                do {
                    let session = try JSONDecoder().decode(GetNewSession.self, from: data)
                    response(session)
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
