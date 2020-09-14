//
//  AddingGroupTableViewControllerViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import CoreData

final class AddingGroupTableViewControllerViewModel: AddingGroupTableViewControllerViewModelType {
    
    var fetcher: DataFetcher?
    var groups: [Group]?
    var filteredGroups: [Group]?
    var fetchedResultsController: NSFetchedResultsController<Groupa>
    var coreDataStack: CoreDataStack
    
    init(fetchedResultsController: NSFetchedResultsController<Groupa>, coreDataStack: CoreDataStack, fetcher: DataFetcher = NetworkDataFetcher() ) {
        self.fetcher = fetcher
        self.fetchedResultsController = fetchedResultsController
        self.coreDataStack = coreDataStack
    }
    
    func getGroupsData(complition: @escaping () -> Void) {
        fetcher?.getGroups(response: { (groups, error) in
            if error != nil {
                print("error lOADING GROUPS \(error?.localizedDescription ?? "")")
            }
            self.groups = groups
            self.filteredGroups = groups
            complition()
        })
    }
    
    func newGroupSelected(atIndexPath indexPath: IndexPath) {
        let group = Groupa(context: coreDataStack.managedContext)
        group.groupName = filteredGroups![indexPath.row].name
        group.subgroupNumb = 1
        coreDataStack.saveContext()
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
