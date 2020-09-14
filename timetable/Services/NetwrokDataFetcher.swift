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
    func getGroups(response: @escaping ([Group]?, Error?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    let networkService: Networking
    
    init(networkService: Networking = NetworkService()){
        self.networkService = networkService
    }
    
    func getGroups(response: @escaping ([Group]?, Error?) -> Void){
        networkService.request(forString: "https://journal.bsuir.by/api/v1/groups") { (data, err) in
            if err != nil {
                print("error loading data \(err!.localizedDescription)")
            }
            guard let data = data else { return }
            let groups = try? JSONDecoder().decode([Group].self, from: data)
            response(groups, err)
        }
    }
    
    func getTimetable(forGroupId groupId: String, response: @escaping (Timetable?, Error?) -> Void) {
        networkService.request(forString: "https://journal.bsuir.by/api/v1/studentGroup/schedule?studentGroup=\(groupId)") { (data, error) in
            if error != nil {
                print("error loading data \(error!.localizedDescription)")
            }
            guard let data = data else { return }
            let timetable = try? JSONDecoder().decode(Timetable.self, from: data)
            response(timetable, error)
        }
    }
}
