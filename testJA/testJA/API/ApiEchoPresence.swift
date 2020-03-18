//
//  ApiEchoPresence.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

enum ApiEchoPresence {
    
    static var authToken : String?
    
    case login(email: String, password: String)
    case signin(name : String, email: String, password: String)
    case text
}

extension ApiEchoPresence : Requestable {
    
    func body() -> Data? {
        
        var json : [String : Any]
        
        switch self {
        case .login(let email, let password):
            json = [
                "email" : email,
                "password" : password
            ]
        case .signin(let name, let email, let password):
            json = [
                "name" : name,
                "email" : email,
                "password" : password
            ]
        default:
            return nil
        }
        
        let data = try? JSONSerialization.data(withJSONObject: json)
        return data
    }
    
    func httpMethod() -> String {
        
        switch self {
        case .text:
            return "GET"
        default:
            return "POST"
        }
    }
    
    func headers() -> [String : String] {
        
        var defaultHeaders : [String : String] = [
            "accept" : "application/json",
            "content-type" : "application/json"
        ]
        
        switch self {
        case .text:
            defaultHeaders["Authorization"] = "Bearer \(ApiEchoPresence.authToken ?? "")"
            return defaultHeaders
        default:
            return defaultHeaders
        }
    }
    
    func apiEndPoint() -> String {
        
        switch self {
        case .signin:
            return "signin/"
        case .login:
            return "login/"
        case .text:
            return "get/text/"
        }
    }
}
