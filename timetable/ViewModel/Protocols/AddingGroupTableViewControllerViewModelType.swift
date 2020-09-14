//
//  AddingGroupTableViewControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

protocol AddingGroupTableViewControllerViewModelType {
    func getGroupsData(complition: @escaping () -> Void)
    func addGroupCellViewModel(forIndexPath indexPath: IndexPath) -> AddingGroupTableViewControllerCellViewModelType?
    func numberOfRows() -> Int
    func textDidChanged(withText text: String)
    func synchWithSearch(serachText text: String)
    func newGroupSelected(atIndexPath indexPath: IndexPath)
}
