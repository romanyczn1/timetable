//
//  ViewControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

protocol ViewControllerViewModelType: class {
    func rightSwipeOccured()
    func leftSwipeOccured()
    func tableViewCellViewModel(forSubgroup subgroup: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    func collectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType?
    func numberOfRowsInTableView(forSubgroup subgroup: Int) -> Int
    func numberOfRowsInCollectionView() -> Int
    func getTimetableData(forGroup group: String, completion: @escaping () -> Void)
}
