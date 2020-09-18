//
//  ViewControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import CoreData

protocol ViewControllerViewModelType: class {
    var fetchedResultsController: NSFetchedResultsController<Groupa> { get }
    
    func rightSwipeOccured()
    func leftSwipeOccured()
    func headerViewWrapperViewModel() -> HeaderViewWrapperViewModelType?
    func tableViewCellViewModel(forSubgroup subgroup: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    func collectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType?
    func headerViewViewModel() -> HeaderViewViewModelType?
    func numberOfRowsInTableView(forSubgroup subgroup: Int) -> Int
    func numberOfRowsInCollectionView() -> Int
    func getTimetableData(forGroup group: String, completion: @escaping () -> Void)
    func setDate(date: MyDate, indexPath: IndexPath)
    func tryGetSelectedGroup(complition: @escaping (String?, Int?) -> Void)
}
