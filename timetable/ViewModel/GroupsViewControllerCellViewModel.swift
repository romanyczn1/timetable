//
//  GroupsViewControllerCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/13/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

final class GroupsViewControllerCellViewModel: GroupsViewControllerCellViewModelType {
    
    var isMain: Bool
    var groupName: String
    var subgroupNumb: Int
    
    
    init(groupName: String, subgroupNumb: Int, isMain: Bool) {
        self.groupName = groupName
        self.subgroupNumb = subgroupNumb
        self.isMain = isMain
    }
}
