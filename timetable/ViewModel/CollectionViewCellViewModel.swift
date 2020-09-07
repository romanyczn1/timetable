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
    var indexPath: IndexPath
    var color: UIColor
    let date: MyDate
    
    let weekdayNames = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    let numberOfDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init(forIndexPath indexPath: IndexPath, forDate date: MyDate) {
        self.indexPath = indexPath
        self.date = date
        if indexPath.row == date.selectedWeekday {
            color = .blue
        } else {
            color = .black
        }
        weekdayName = weekdayNames[indexPath.row]
        setDate(date: date, indexPath: indexPath)
    }
    
    private func setDate(date: MyDate, indexPath: IndexPath) {
        
        let day = date.day - ( date.selectedWeekday - indexPath.row)
        weekdayDate = "\(day)"
    }
}
