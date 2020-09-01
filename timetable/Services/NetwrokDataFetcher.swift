//
//  NetwrokDataFetcher.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

protocol DataFetcher: class {
    func getTimetable(forGroupId groupId: String, response: @escaping (Timetable?, Error?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    let networkService: Networking
    
    init(networkService: Networking = NetworkService()){
        self.networkService = networkService
    }
    
    func getTimetable(forGroupId groupId: String, response: @escaping (Timetable?, Error?) -> Void) {
        networkService.request(forGroupId: groupId) { (data, error) in
            if error != nil {
                print("error loading data \(error!.localizedDescription)")
            }
            guard let data = data else { return }
            let timetable = try? JSONDecoder().decode(Timetable.self, from: data)
            response(timetable, error)
        }
    }
}
