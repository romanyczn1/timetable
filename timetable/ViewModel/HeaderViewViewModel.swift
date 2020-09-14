//
//  HeaderViewViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/11/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

class HeaderViewViewModel: HeaderViewViewModelType {
    var weekdayName: String
    let wekkdayNames = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    init(forDate date: MyDate) {
        self.weekdayName = wekkdayNames[date.selectedWeekday]
    }
}
