//
//  LessonCD+CoreDataProperties.swift
//  timetable
//
//  Created by Roman Bukh on 10/2/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//
//

import Foundation
import CoreData


extension LessonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LessonCD> {
        return NSFetchRequest<LessonCD>(entityName: "LessonCD")
    }

    @NSManaged public var subject: String?
    @NSManaged public var lessonTime: String?
    @NSManaged public var startLessonTime: String?
    @NSManaged public var endLessonTime: String?
    @NSManaged public var lessonType: String?
    @NSManaged public var numSubgroup: Int64
    @NSManaged public var auditory: [String]?
    @NSManaged public var note: String?
    @NSManaged public var weekNumber: [Int]?
    @NSManaged public var employee: NSSet?
    @NSManaged public var ofSchedule: ScheduleCD?

}

// MARK: Generated accessors for employee
extension LessonCD {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: EmployeeCD)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: EmployeeCD)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}
