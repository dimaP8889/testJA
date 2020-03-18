//
//  EnterResponse.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

struct EnterResponse : Decodable {
    
    let success : Bool
    let data : EnterData
    let errors : [String]
}
