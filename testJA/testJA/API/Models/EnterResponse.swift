//
//  EnterResponse.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

protocol Errorable : Decodable {
    
    var errors : [ErrorResponse] { get }
}

struct EnterResponse : Errorable {
    
    let success : Bool
    let data : EnterData
    let errors : [ErrorResponse]
}

struct ErrorResponse : Decodable {
    
    let message : String
}
