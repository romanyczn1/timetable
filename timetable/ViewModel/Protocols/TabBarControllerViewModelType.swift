//
//  TabBarControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 9/13/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import CoreData

protocol TabBarControllerViewModelType {
    var coreDataStack: CoreDataStack { get }
    var fetchedResultsController: NSFetchedResultsController<Groupa> { get }
    func groupsViewControllerViewModel() -> GroupsViewControllerViewModelType
}
