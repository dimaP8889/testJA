//
//  TextResponse.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

struct TextResponse : Errorable {
    
    let success : Bool
    let data : String?
    let errors : [ErrorResponse]
    
    private enum CodingKeys: String, CodingKey {
        case success
        case data
        case errors
    }

    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.success = try container.decode(Bool.self, forKey: .success)
        self.errors = try container.decode([ErrorResponse].self, forKey: .errors)
        self.data = try? container.decode(String.self, forKey: .data)
    }
}
