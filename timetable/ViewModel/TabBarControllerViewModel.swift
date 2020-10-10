//
//  TabBarControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/13/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import CoreData

final class TabBarControllerViewModel: TabBarControllerViewModelType {
    func viewControllerViewModel() -> ScheduleViewControllerViewModelType {
        return ScheduleViewControllerViewModel.init(fetchedResultsController: fetchedResultsController, coreDataStack: coreDataStack)
    }
    
    
    lazy var coreDataStack = CoreDataStack(modelName: "Timetable")
    lazy var fetchedResultsController: NSFetchedResultsController<Groupa> = {
        let fetchRequest: NSFetchRequest<Groupa> = Groupa.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Groupa.groupName), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController( fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    func groupsViewControllerViewModel() -> GroupsViewControllerViewModelType {
        return GroupsViewControllerViewModel.init(fetchedResultsController: fetchedResultsController, coreDataStack: coreDataStack)
    }
}
