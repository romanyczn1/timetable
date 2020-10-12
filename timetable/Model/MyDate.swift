//
//  File.swift
//  timetable
//
//  Created by Roman Bukh on 9/4/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

struct MyDate {
    var day: Int
    var month: Int
    var year: Int
    var selectedWeekday: Int
}

extension MyDate: Equatable {
    static func == (firstDate: MyDate, secondDate: MyDate) -> Bool {
        if firstDate.day == secondDate.day && firstDate.month == secondDate.month && firstDate.year == secondDate.year {
            return true
        } else {
            return false
        }
    }
}

enum DayType {
    case bussiness
    case weekend
}
