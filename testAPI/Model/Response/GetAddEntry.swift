//
//  GetAddEntry.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class GetAddEntry : Decodable{
    
    let status : Int
    let data : IdValue
    
        enum CodingKeys: String, CodingKey {
            case status
            case data
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            status = try container.decode(Int.self, forKey: .status)
            data = try container.decode(IdValue.self, forKey: .data)
        }
}

final class IdValue : Decodable{
    
    let id : String

       enum CodingKeys: String, CodingKey {
           case id
  
       }
      
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           id = try container.decode(String.self, forKey: .id)
       }
}

