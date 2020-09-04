//
//  CollectionViewCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/3/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellViewModel: CollectionViewCellViewModelType {
    
    var weekdayName: String = ""
    var weekdayDate: String = ""
    
    let weekdayNames = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    let numberOfDaysInMonths = ["31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"]
    //dont forget about 29 in fabruary
    
    init(forIndexPath indexPath: IndexPath,forDate date: MyDate) {
        setDate(name: weekdayNames[indexPath.row], day: 1)
    }
    
    private func setDate(name: String, day: Int) {
        weekdayName = name
        weekdayDate = "\(day)"
    }
}
