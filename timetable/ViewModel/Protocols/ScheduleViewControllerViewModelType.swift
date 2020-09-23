//
//  ViewControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ScheduleViewControllerViewModelType: class {
    var fetchedResultsController: NSFetchedResultsController<Groupa> { get }
    
    func getCurrentWeekNumber(updateCacheOrNot: Bool, completion: @escaping () -> Void)
    func refreshDate(completion: @escaping () -> Void)
    func goToStartDate(completion: @escaping () -> Void)
    func rightSwipeOccured()
    func leftSwipeOccured()
    func tableViewCellViewModel(forSubgroup subgroup: Int, forIndexPath indexPath: IndexPath, traitCollection: UITraitCollection) -> TableViewCellViewModelType?
    func collectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType?
    func headerViewViewModel() -> HeaderViewViewModelType?
    func selectedDayViewViewModel() -> SelectedDayViewViewModelType?
    func numberOfRowsInTableView(forSubgroup subgroup: Int) -> Int
    func numberOfRowsInCollectionView() -> Int
    func getTimetableData(forGroup group: String, updateCacheOrNot: Bool, completion: @escaping () -> Void)
    func setDate(date: MyDate, indexPath: IndexPath)
    func tryGetSelectedGroup(complition: @escaping (String?, Int?) -> Void)
}
