//
//  NetworkDataFetcher.swift
//  testAPI
//
//  Created by maksim on 05.09.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class NetworkDataFetcher{
    
    fileprivate let networkService : NetworkService? = NetworkService()
    
    func fetchSession<T>(httpBody : T, response: @escaping (GetNewSession?) -> Void) {
        networkService!.request(httpBody: httpBody) { (result) in
            switch result {
            case .success(let data):
                do {
                    print("data",String(data: data, encoding: .utf8))
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
    
    func fetchEntry<T>(httpBody : T, response: @escaping (GetEntries?) -> Void) {
        networkService!.request(httpBody: httpBody) { (result) in
            switch result {
            case .success(let data):
                do {
                    print("data",String(data: data, encoding: .utf8))
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
    
    func fetchCreateEntry<T>(httpBody : T, response: @escaping (GetAddEntry?) -> Void) {
        networkService!.request(httpBody: httpBody) { (result) in
            switch result {
            case .success(let data):
                do {
                    print("data",String(data: data, encoding: .utf8))
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
