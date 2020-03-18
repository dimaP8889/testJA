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
    let data : [String : String]
    let successData : String
    let errors : [ErrorResponse]
    
}
