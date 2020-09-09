//
//  TableViewCellViewModelType.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCellViewModelType {
    var lessonType: String { get }
    var lessonTime: String { get }
    var lessonName: String { get }
    var lessonAuditory: String? { get }
    var teacherName: String? { get }
    var teacherLastName: String? { get }
    var tacherFirstName: String? { get }
    var teacherMiddleName: String? { get }
    var cellColor: UIColor { get }
    var delegate: TableViewCellViewModelDelegate? { get set }
}
