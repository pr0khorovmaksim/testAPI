//
//  NetworkDataFetcher.swift
//  testAPI
//
//  Created by maksim on 05.09.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class NetworkDataFetcher{
    
    fileprivate let networkService = NetworkService()
    
    func fetchSession(httpBody : String, response: @escaping (GetNewSession?) -> Void) {
        networkService.request(httpBody: httpBody) { (result) in
            switch result {
            case .success(let data):
                do {
                    let session = try JSONDecoder().decode(GetNewSession.self, from: data)
                    response(session)
                } catch let jsonError {
                    print("Ошибка декодирования JSON \(jsonError)")
                    response(nil)
                }
            case .failure(let error):
                print("Ошибка при запросе данных: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
   func fetchEntry(httpBody : String, response: @escaping (GetEntries?) -> Void) {
          networkService.request(httpBody: httpBody) { (result) in
            switch result {
            case .success(let data):
                print("return",String(data: data, encoding: .utf8))
                do {
                    let entry = try JSONDecoder().decode(GetEntries.self, from: data)
                    response(entry)
                } catch let jsonError {
                    print("Ошибка декодирования JSON \(jsonError)")
                    response(nil)
                }
            case .failure(let error):
                print("Ошибка при запросе данных: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func fetchCreateEntry(httpBody : String, response: @escaping (GetAddEntry?) -> Void) {
           networkService.request(httpBody: httpBody) { (result) in
               switch result {
               case .success(let data):
                   do {
                       let entry = try JSONDecoder().decode(GetAddEntry.self, from: data)
                       response(entry)
                   } catch let jsonError {
                       print("Ошибка декодирования JSON \(jsonError)")
                       response(nil)
                   }
               case .failure(let error):
                   print("Ошибка при запросе данных: \(error.localizedDescription)")
                   response(nil)
               }
           }
       }
}
