//
//  TableViewCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/31/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    
    var lessonType: String
    var lessonTime: String
    var lessonName: String
    var lessonAuditory: String
    var teacherName: String
    
    init(forLesson lesson: Lesson, forIndexPath idnexPath: IndexPath) {
        self.lessonType = lesson.lessonType
        self.lessonTime = lesson.lessonTime
        self.lessonName = lesson.subject
        self.lessonAuditory = lesson.auditory[0]
        self.teacherName = lesson.employee[0].fio
    }
}
