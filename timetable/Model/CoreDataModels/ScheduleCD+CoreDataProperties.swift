//
//  ScheduleCD+CoreDataProperties.swift
//  timetable
//
//  Created by Roman Bukh on 10/2/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//
//

import Foundation
import CoreData


extension ScheduleCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduleCD> {
        return NSFetchRequest<ScheduleCD>(entityName: "ScheduleCD")
    }

    @NSManaged public var weekday: String?
    @NSManaged public var ofTimetable: TimetableCD?
    @NSManaged public var schedule: NSSet?

}

// MARK: Generated accessors for schedule
extension ScheduleCD {

    @objc(addScheduleObject:)
    @NSManaged public func addToSchedule(_ value: LessonCD)

    @objc(removeScheduleObject:)
    @NSManaged public func removeFromSchedule(_ value: LessonCD)

    @objc(addSchedule:)
    @NSManaged public func addToSchedule(_ values: NSSet)

    @objc(removeSchedule:)
    @NSManaged public func removeFromSchedule(_ values: NSSet)

}
