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
    var numberOfDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init(forIndexPath indexPath: IndexPath, forDate date: MyDate, realWorldDate: MyDate) {
        self.date = date
        self.color = .black
        setDate(date: date, indexPath: indexPath, realWorldDate: realWorldDate)
    }
    
    private func setDate(date: MyDate, indexPath: IndexPath, realWorldDate: MyDate) {
        if date.year % 4 == 0 {
            numberOfDaysInMonths[1] = 29
        } else {
            numberOfDaysInMonths[1] = 28
        }
        var day = date.day - ( date.selectedWeekday - indexPath.row)
        if day  < 1 {
            if date.month != 1 {
                day = numberOfDaysInMonths[date.month - 2] + day
            } else {
                day = numberOfDaysInMonths[11] + day
            }
            self.date.month -= 1
            if self.date.month == 0 {
                self.date.year -= 1
                self.date.month = 12
            }
        }
        if day > numberOfDaysInMonths[self.date.month - 1] {
            day = day - numberOfDaysInMonths[date.month - 1]
            self.date.month += 1
            if self.date.month == 13 {
                self.date.year += 1
                self.date.month = 1
            }
        }
        self.date.day = day
        if self.date.day == realWorldDate.day && self.date.month == realWorldDate.month && self.date.year == realWorldDate.year {
            color = #colorLiteral(red: 0.03088182025, green: 0.5741170049, blue: 0.7236190438, alpha: 1)
        } else {
            if #available(iOS 13.0, *) {
                color = .label
            } else {
                color = .black
            }
        }
        self.date.selectedWeekday = indexPath.row
        weekdayDate = "\(day)"
        weekdayName = weekdayNames[indexPath.row]
    }
}
