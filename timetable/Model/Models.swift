//
//  Models.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

struct Timetable: Decodable {
    let employee: String?
    let studentGroup: StrudentGroup
    let schedules: [Schedule]
    let currentWeekNumber: Int
    let todayDate: String
}

struct StrudentGroup: Decodable {
    let name: String
    let course: Int
}

struct Schedule: Decodable {
    let weekDay: String
    let schedule: [Lesson]
}

struct Lesson: Decodable {

    let subject: String
    let lessonTime: String
    let startLessonTime: String
    let endLessonTime: String
    let lessonType: String
    let employee: [Employee]
    let numSubgroup: Int
    let auditory: [String]
    let note: String?
    let weekNumber: [Int]
}

struct Employee: Decodable {
    let firstName: String
    let lastName: String
    let middleName: String
    let photoLink: String?
    let fio: String
}

extension Employee: Equatable {
    static func == (firstEmployee: Employee, secondEmployee: Employee) -> Bool {
        if firstEmployee.fio == secondEmployee.fio {
            return true
        }
        return false
    }
}
