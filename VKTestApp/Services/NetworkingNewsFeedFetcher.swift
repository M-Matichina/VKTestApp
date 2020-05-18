//
//  NewsFeedFetcher.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/17/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getNewsFeed(startFrom: String?, response: @escaping (NewsFeedResponse?) -> Void)
}

struct NetworkingNewsFeedFetcher: DataFetcher {
    
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    
    func getNewsFeed(startFrom: String?, response: @escaping (NewsFeedResponse?) -> Void) {
        var params = [
            "filters": "post",
            "count": "15"
        ]
        
        if let startFrom = startFrom {
            params["start_from"] = startFrom
        }
        
        networking.request(path: API.host, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = self.decodeJSOn(type: NewsFeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    // MARK: для общего типа
    
    func decodeJSOn<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let respone = try? decoder.decode(type.self, from: data) else { return nil }
        return respone
    }
    
    
}
