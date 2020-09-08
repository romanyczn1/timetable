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
    var color: UIColor
    var date: MyDate
    
    let weekdayNames = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    let numberOfDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init(forIndexPath indexPath: IndexPath, forDate date: MyDate) {
        self.date = date
        if indexPath.row == date.selectedWeekday {
            color = .blue
        } else {
            color = .black
        }
        setDate(date: date, indexPath: indexPath)
    }
    
    private func setDate(date: MyDate, indexPath: IndexPath) {
        var day = date.day - ( date.selectedWeekday - indexPath.row)
        if day < 1 {
            day = numberOfDaysInMonths[date.month - 2] + day
            self.date.month -= 1
            //dont forget bout year
        }
        if day > numberOfDaysInMonths[self.date.month - 1] {
            day = day - numberOfDaysInMonths[date.month - 1]
            self.date.month += 1
            //dont forget bout year
        }
        self.date.day = day
        self.date.selectedWeekday = indexPath.row
        weekdayDate = "\(day)"
        weekdayName = weekdayNames[indexPath.row]
    }
}
