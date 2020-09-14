//
//  AddingGroupTableViewControllerCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

final class AddingGroupTableViewControllerCellViewModel: AddingGroupTableViewControllerCellViewModelType {
    
    let groupName: String
    
    init(groupName: String){
        self.groupName = groupName
    }
}
