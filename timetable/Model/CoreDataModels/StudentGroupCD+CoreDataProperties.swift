//
//  StudentGroupCD+CoreDataProperties.swift
//  timetable
//
//  Created by Roman Bukh on 10/2/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//
//

import Foundation
import CoreData


extension StudentGroupCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentGroupCD> {
        return NSFetchRequest<StudentGroupCD>(entityName: "StudentGroupCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var course: Int16
    @NSManaged public var forTimetable: TimetableCD?

}
