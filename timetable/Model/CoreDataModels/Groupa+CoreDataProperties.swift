//
//  Groupa+CoreDataProperties.swift
//  timetable
//
//  Created by Roman Bukh on 10/2/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//
//

import Foundation
import CoreData


extension Groupa {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Groupa> {
        return NSFetchRequest<Groupa>(entityName: "Groupa")
    }

    @NSManaged public var groupName: String?
    @NSManaged public var isMain: Bool
    @NSManaged public var subgroupNumb: Int16
    @NSManaged public var timetable: TimetableCD?

}
