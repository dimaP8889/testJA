//
//  Requestable.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

protocol Requestable {
    
    func body() -> Data?
    func parameters() -> [String:String]
    func headers() -> [String : String]
    func apiRoute() -> String
    func apiEndPoint() -> String
    func httpMethod() -> String
}

extension Requestable {
    
    func body() -> Data? {
        return nil
    }
    func parameters() -> [String : String] {
        return [:]
    }
    func headers() -> [String : String] {
        return [:]
    }
    func apiRoute() -> String {
        return "api/"
    }
}

// MARK: - URL Request Creator
extension Requestable {
    
    func urlRequest(_ base: URL) -> URLRequest {
        
        let url = base.appendingPathComponent("\(apiRoute())\(apiEndPoint())")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = parameters().compactMap {
            URLQueryItem(name: $0, value: $1)
        }
        
        let query = components?.percentEncodedQuery
            
        components?.percentEncodedQuery = query?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let _url = components?.url else {
            fatalError("Recheck params")
        }
        
        return URLRequest(url: _url)
    }
}
