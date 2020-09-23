//
//  SelectedDayViewViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 9/20/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class SelectedDayViewViewModel: SelectedDayViewViewModelType {
    
    var weekdayNumber: Int
    
    init(forDate date: MyDate) {
        self.weekdayNumber = date.selectedWeekday
    }
    
}
