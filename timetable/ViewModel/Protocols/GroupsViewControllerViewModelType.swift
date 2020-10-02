//
//  GroupsViewControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol GroupsViewControllerViewModelType {
    var fetchedResultsController: NSFetchedResultsController<Groupa> { get }
    
    func numberOfRows() -> Int
    func deleteObject(atIndexPath indexPath: IndexPath)
    func groupsViewControllerCellViewModel(forIndexPath indexPath: IndexPath) -> GroupsViewControllerCellViewModelType
    func cellSelected(atIndexPath indexPath: IndexPath/*, tabBarController: UITabBarController*/)
    func editSelectedGroupData(tabBarController: UITabBarController)
    func addingGroupViewModel() -> AddingGroupTableViewControllerViewModelType
}
