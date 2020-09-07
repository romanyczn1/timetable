//
//  CollectionViewCellViewModel.swift
//  timetable
//
//  Created by Roman Bukh on 8/30/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewCellViewModelType {
    var weekdayName: String { get }
    var weekdayDate: String { get }
    var color: UIColor { get }
}
