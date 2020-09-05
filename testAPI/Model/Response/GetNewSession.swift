//
//  Model.swift
//  testAPI
//
//  Created by maksim on 10.08.2020.
//  Copyright © 2020 maksim. All rights reserved.
//

import Foundation

final class GetNewSession : Decodable{
    
    let status : Int?
    let data : SessionValue?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        data = try container.decode(SessionValue.self, forKey: .data)
    }
}

final class SessionValue : Decodable {
    
    let session : String
    
    enum CodingKeys: String, CodingKey {
        case session
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        session = try container.decode(String.self, forKey: .session)
    }
}

