//
//  GroupsViewControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class GroupsViewControllerViewModel: GroupsViewControllerViewModelType {    
    
    var fetchedResultsController: NSFetchedResultsController<Groupa>
    var coreDataStack: CoreDataStack
    
    init(fetchedResultsController: NSFetchedResultsController<Groupa>, coreDataStack: CoreDataStack) {
        self.fetchedResultsController = fetchedResultsController
        self.coreDataStack = coreDataStack
    }
    
    func cellSelected(atIndexPath indexPath: IndexPath, tabBarController: UITabBarController) {
        let group = fetchedResultsController.object(at: indexPath)
                fetchedResultsController.fetchedObjects?.map({ (group) in
                    group.isMain = false
                })
                group.isMain = true
                if let controller = tabBarController.viewControllers![0] as? ViewController {
                    controller.selectedGroup = group.groupName ?? ""
                }
                coreDataStack.saveContext()
    }
    
    func groupsViewControllerCellViewModel(forIndexPath indexPath: IndexPath) -> GroupsViewControllerCellViewModelType {
        let group = fetchedResultsController.object(at: indexPath)
        return GroupsViewControllerCellViewModel.init(groupName: group.groupName!, subgroupNumb: Int(group.subgroupNumb))
    }
    
    func deleteObject(atIndexPath indexPath: IndexPath) {
        let group = fetchedResultsController.object(at: indexPath)
        coreDataStack.managedContext.delete(group)
        coreDataStack.saveContext()
    }
    
    func numberOfRows() -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[0] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
}
