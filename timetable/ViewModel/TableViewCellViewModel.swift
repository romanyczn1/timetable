//
//  TableViewCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/31/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellViewModel: TableViewCellViewModelType {
    
    var lessonType: String
    var lessonTime: String
    var lessonName: String
    var lessonAuditory: String
    var teacherName: String
    var cellColor: UIColor
    
    init(forLesson lesson: Lesson, forIndexPath idnexPath: IndexPath) {
        self.lessonType = lesson.lessonType
        self.lessonTime = lesson.lessonTime
        self.lessonName = lesson.subject
        if lesson.auditory != [] {
            self.lessonAuditory = lesson.auditory[0]
        }else {
            self.lessonAuditory = ""
        }
        if lesson.employee != [] {
            self.teacherName = lesson.employee[0].fio
        }else {
            self.teacherName = ""
        }
        switch lessonType {
        case "ЛК" : self.cellColor = UIColor.green
        case "ПЗ" : self.cellColor = UIColor.yellow
        case "ЛР" : self.cellColor = UIColor.purple
        default:
            self.cellColor = UIColor.white
        }
    }
}
