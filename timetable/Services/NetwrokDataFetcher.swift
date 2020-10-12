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
    func getCurrentWeekNumber(response: @escaping (Int?, Error?) -> Void)
    func updateWeekNumberCache()
    func updateTimetableCache(forGroupId groupId: String)
    func updateGroupsCache()
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
            if groups == nil {
                self.updateGroupsCache()
            } else {
                response(groups, err)
            }
        }
    }
    
    func getTimetable(forGroupId groupId: String, response: @escaping (Timetable?, Error?) -> Void) {
        networkService.request(forString: "https://journal.bsuir.by/api/v1/studentGroup/schedule?studentGroup=\(groupId)") { (data, error) in
            if error != nil {
                print("error loading data \(error!.localizedDescription)")
            }
            guard let data = data else { return }
            let timetable = try? JSONDecoder().decode(Timetable.self, from: data)
            if timetable == nil {
                self.updateTimetableCache(forGroupId: groupId)
            } else {
                response(timetable, error)
            }
        }
    }
    
    func getCurrentWeekNumber(response: @escaping (Int?, Error?) -> Void) {
        networkService.request(forString: "http://journal.bsuir.by/api/v1/week") { (data, error) in
            if error != nil {
                print("error loading data \(error!.localizedDescription)")
            }
            guard let data = data else { return }
            let currentWeekNumber = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Int
            if currentWeekNumber == nil {
                response(9999, error)
                self.updateWeekNumberCache()
            } else {
                response(currentWeekNumber, error)
            }
        }
    }
    
    func updateWeekNumberCache() {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: "http://journal.bsuir.by/api/v1/week")!)
        cache.removeCachedResponse(for: request)

    }
    
    func updateTimetableCache(forGroupId groupId: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: "https://journal.bsuir.by/api/v1/studentGroup/schedule?studentGroup=\(groupId)")!)
        cache.removeCachedResponse(for: request)
    }
    
    func updateGroupsCache() {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: "https://journal.bsuir.by/api/v1/groups")!)
        cache.removeCachedResponse(for: request)
    }
}
