//
//  LessonCell.swift
//  timetable
//
//  Created by Roman Bukh on 8/31/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

class LessonCell: UITableViewCell {
    
    static let reuseId = "LessonCell"
    
    var viewModel: TableViewCellViewModelType? {
        didSet{
            textLabel?.text = "\(viewModel!.lessonName)  \(viewModel!.lessonTime)"
            self.backgroundColor = viewModel?.cellColor
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
