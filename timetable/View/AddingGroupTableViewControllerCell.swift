//
//  AddingGroupTableViewControllerCell.swift
//  timetable
//
//  Created by Roman Bukh on 9/12/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class AddingGroupTableViewControllerCell: UITableViewCell {
    
    static let reuseId = "AddingGroupTableViewControllerCell"
    
    var viewModel: AddingGroupTableViewControllerCellViewModelType? {
        willSet(viewModel){
            self.textLabel?.text = viewModel?.groupName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
