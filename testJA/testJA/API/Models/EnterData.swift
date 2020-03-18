//
//  EnterData.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

struct EnterData : Decodable {
    
    let uid : Int
    let name : String
    let email : String
    let access_token : String
    let role : Int
    let status : Int
    let created_at : Int
    let updated_at : Int
}
