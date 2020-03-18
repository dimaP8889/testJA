//
//  ApiManager.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation

final class Networking {
    
    static let apiEchoPresence = ApiManager<ApiEchoPresence>(base: "https://apiecho.cf/")!
}

class ApiManager<RQ : Requestable> {
    
    let base : URL
    var session = URLSession(configuration: .default)
    
    init?(base: String) {
        
        guard let _base = URL(string: base) else { return nil }
        
        self.base = _base
    }
    
    func dataTask<T : Decodable>(for request: RQ, type: T.Type, completion : @escaping (APIResult<T>) -> Void) -> URLSessionDataTask {
        
        var urlRequest = request.urlRequest(base)
        
        urlRequest.httpBody = request.body()
        urlRequest.allHTTPHeaderFields = request.headers()
        urlRequest.httpMethod = request.httpMethod()
        
        let task = session.dataTask(with: urlRequest) { [unowned self] (data, response, error) in
            self.responseIsOK(data, response, error) { (result) in
                
                switch result {
                    
                case .success(let data):
                    
                    do {
                        completion(
                            .success(try JSONDecoder().decode(type.self, from: data))
                        )
                    } catch (let decodeError) {
                        
                        completion(
                            .failure(.jsonMappingFailed(decodeError))
                        )
                    }
                case .failure(let errorCode):
                    completion(
                        .failure(errorCode)
                    )
                }
            }
        }
        
        return task
    }
    
    private func responseIsOK(
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        completion: @escaping (APIResult<Data>)->()
    ) {
        guard error == nil else {
            return completion(
                .failure(
                    .onRequestExecute(error!)
                )
            )
        }
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            return completion(
                .failure(
                    .missingHTTPCode
                )
            )
        }
        
        guard 200..<300 ~= code else {
            return completion(
                .failure(
                    .badHTTPCode(code)
                )
            )
        }
        
        guard let _data = data else {
            return completion(
                .failure(
                    .missingData
                )
            )
        }
        
        completion(
            .success(_data)
        )
    }
}

extension ApiManager where RQ : Requestable {
    
    func sync<T : Decodable>(request: RQ) -> T? {
        
        var result : APIResult<T>!
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global(qos: .userInteractive).async {  [unowned self] in
            self.dataTask(for: request, type: T.self) { (_result) in
                result = _result
                group.leave()
            }.resume()
        }
        
        group.wait()
        
        switch result {
        case .success(let data):
            return data
        case .failure(let apiError):
            presentAlert(with: apiError.localizedDescription)
            return nil
        case .none:
            fatalError()
        }
    }
}

extension ApiManager where RQ == ApiEchoPresence {
    
    /// Returns login result
    func login(email: String, password: String) -> Bool {
        
        let model : EnterResponse? = sync(request: .login(email: email, password: password))
        ApiEchoPresence.authToken = model?.data.access_token
        
        return model?.data.access_token != nil
    }
    
    /// Returns signin result
    func signin(name: String, email: String, password: String) -> Bool {
        
        let model : EnterResponse? = sync(request: .signin(name: name, email: email, password: password))
        ApiEchoPresence.authToken = model?.data.access_token
        
        return model?.data.access_token != nil
    }
    
    /// Returns generated text
    func getText() -> String {
        
        let model : TextResponse? = sync(request: .text)
        return model?.data ?? ""
    }
}

extension ApiManager : ErrorAlert {}

enum APIResult<T> {

    case success(T)
    case failure(APIError)
}

enum APIError: Error {
    
    case onRequestCreation
    case onRequestExecute(Error)
    case missingHTTPCode
    case badHTTPCode(Int)
    case missingData
    case jsonMappingFailed(Error)
}
