//
//  NetworkService.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/17/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation

protocol Networking {
    
    func request(path: String, params: [String: String], complition: @escaping (Data?, Error?) -> Void)
}


class NetworkService: Networking {
    
    private let authService = AuthService()
    
    func request(path: String, params: [String : String], complition: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: API.path, params: allParams)
        
        // MARK: работа с сетью
        
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Данныя запрос не должен выполняться в main потоке. Лучше в фоновом режиме.
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
        task.resume()
        print(url)
    }
    
    
    
    // MARK:- func возвращающая URL
    
    func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}

/* allParams содержит 3 элемента:
 ["filters"]
 ["access_token"]
 ["version"]
 
 Для каждого элемента создается URLQueryItem
 $0 - это  ["filters"] ,["access_token"] или ["version"]
 $1 - это "post", token или API.version
 */
