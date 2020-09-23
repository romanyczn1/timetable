//
//  NetworkService.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

protocol Networking: class {
    func request(forString string: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    func request(forString string: String, completion: @escaping (Data?, Error?) -> Void) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: string)!)
        
        if let data = cache.cachedResponse(for: request)?.data {
            completion(data, nil)
        } else {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    completion(data, error)
                }
            }.resume()
        }
        
    }
}
