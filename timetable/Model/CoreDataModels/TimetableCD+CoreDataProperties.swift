//
//  TimetableCD+CoreDataProperties.swift
//  timetable
//
//  Created by Roman Bukh on 10/2/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//
//

import Foundation
import CoreData


extension TimetableCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableCD> {
        return NSFetchRequest<TimetableCD>(entityName: "TimetableCD")
    }

    @NSManaged public var employee: String?
    @NSManaged public var currentWeekNumber: Int16
    @NSManaged public var todayDate: String?
    @NSManaged public var studentGroup: StudentGroupCD?
    @NSManaged public var scedules: NSSet?
    @NSManaged public var ofGroup: Groupa?

}

// MARK: Generated accessors for scedules
extension TimetableCD {

    @objc(addScedulesObject:)
    @NSManaged public func addToScedules(_ value: ScheduleCD)

    @objc(removeScedulesObject:)
    @NSManaged public func removeFromScedules(_ value: ScheduleCD)

    @objc(addScedules:)
    @NSManaged public func addToScedules(_ values: NSSet)

    @objc(removeScedules:)
    @NSManaged public func removeFromScedules(_ values: NSSet)

}
