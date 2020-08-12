//
//  GetEntries.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class GetEntries: Decodable {
    
    let status: Int
    let data: [[Body]]
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decode(Int.self, forKey: .status)
        data = try container.decode([[Body]].self, forKey: .data)
    }
}

final class Body: Decodable {
 
       let id: String
       let body: String
       let da: String
       let dm: String
       
    enum CodingKeys: String, CodingKey {
        case id
        case body
        case da
        case dm
    }
   
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        body = try container.decode(String.self, forKey: .body)
        da = try container.decode(String.self, forKey: .da)
        dm = try container.decode(String.self, forKey: .dm)
    }
    
}
