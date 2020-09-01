//
//  NetworkService.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

protocol Networking: class {
    func request(forGroupId groupId: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    func request(forGroupId groupId: String, completion: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: URL(string: "https://journal.bsuir.by/api/v1/studentGroup/schedule?studentGroup=\(groupId)")!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
    
    
}
