//
//  AddingGroupTableViewControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

final class AddingGroupTableViewControllerViewModel: AddingGroupTableViewControllerViewModelType {
    
    var fetcher: DataFetcher?
    var groups: [Group]?
    var filteredGroups: [Group]?
    
    init(fetcher: DataFetcher = NetworkDataFetcher()) {
        self.fetcher = fetcher
    }
    
    func getGroupsData(complition: @escaping () -> Void) {
        fetcher?.getGroups(response: { (groups, error) in
            if error != nil {
                print("error lOADING GROUPS")
            }
            self.groups = groups
            self.filteredGroups = groups
            complition()
        })
    }
    
    func synchWithSearch(serachText text: String) {
        filteredGroups = groups?.filter({ (group) -> Bool in
            group.name.contains(text)
        })
    }
    
    func textDidChanged(withText text: String) {
        if text != "" {
            filteredGroups = groups?.filter({ (group) -> Bool in
                group.name.contains(text)
            })
        } else {
            filteredGroups = groups
        }
    }
    
    func numberOfRows() -> Int {
        return filteredGroups?.count ?? 0
    }
    
    func addGroupCellViewModel(forIndexPath indexPath: IndexPath) -> AddingGroupTableViewControllerCellViewModelType? {
        AddingGroupTableViewControllerCellViewModel.init(groupName: filteredGroups![indexPath.row].name)
    }
    
}
