//
//  ViewControllerViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

protocol ViewControllerViewModelType: class {
    func setSelectedWeekday(selectedWeekday: Int, completion: @escaping (Int) -> Void)
    func getCurrentWeekday() -> Int
    func tableViewCellViewModel(forWeekday weekday: Int, forSubgroup subgroup: Int, forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    func collectionViewCellViewModel() -> CollectionViewCellViewModelType?
    func numberOfRowsInTableView(forWeekday weekday: Int, forSubgroup subgroup: Int) -> Int
    func numberOfRowsInCollectionView() -> Int
    func getTimetableData(forGroup group: String, completion: @escaping () -> Void)
}
