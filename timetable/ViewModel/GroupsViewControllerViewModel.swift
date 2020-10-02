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
    
    func cellSelected(atIndexPath indexPath: IndexPath/*, tabBarController: UITabBarController*/) {
//        guard let controller = tabBarController.viewControllers![0] as? ScheduleViewController else { return }
        let group = fetchedResultsController.object(at: indexPath)
        if group.isMain == true {
            group.subgroupNumb += 1
            if group.subgroupNumb >= 3 {
                group.subgroupNumb = 0
            }
//            controller.selectedSubgroup = Int(group.subgroupNumb)
            coreDataStack.saveContext()
        } else {
            fetchedResultsController.fetchedObjects?.map({ (group) in
                group.isMain = false
            })
            group.isMain = true
            coreDataStack.saveContext()
//            controller.selectedGroup = group.groupName ?? ""
//            controller.selectedSubgroup = Int(group.subgroupNumb)
        }
    }
    
    func editSelectedGroupData(tabBarController: UITabBarController) {
        guard let controller = tabBarController.viewControllers![0] as? ScheduleViewController else { return }
        let group = fetchedResultsController.fetchedObjects?.first(where: { (group) -> Bool in
            group.isMain == true
        })
        if controller.selectedGroup == group?.groupName {
            controller.selectedSubgroup = Int(group!.subgroupNumb)
        } else {
            controller.selectedGroup = group?.groupName ?? ""
            controller.selectedSubgroup = Int(group?.subgroupNumb ?? 0)
        }
    }
    
    func groupsViewControllerCellViewModel(forIndexPath indexPath: IndexPath) -> GroupsViewControllerCellViewModelType {
        let group = fetchedResultsController.object(at: indexPath)
        return GroupsViewControllerCellViewModel.init(groupName: group.groupName!, subgroupNumb: Int(group.subgroupNumb), isMain: group.isMain)
    }
    
    func addingGroupViewModel() -> AddingGroupTableViewControllerViewModelType {
        return AddingGroupTableViewControllerViewModel.init(fetchedResultsController: fetchedResultsController, coreDataStack: coreDataStack)
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
