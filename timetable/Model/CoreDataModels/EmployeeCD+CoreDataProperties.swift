//
//  EmployeeCD+CoreDataProperties.swift
//  timetable
//
//  Created by Roman Bukh on 10/2/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeCD> {
        return NSFetchRequest<EmployeeCD>(entityName: "EmployeeCD")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?
    @NSManaged public var photoLink: String?
    @NSManaged public var fio: String?
    @NSManaged public var forLesson: LessonCD?

}
