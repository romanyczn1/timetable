//
//  GroupsViewControllerCell.swift
//  timetable
//
//  Created by Roman Bukh on 9/13/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class GroupsViewControllerCell : UITableViewCell {
    
    static let reuseId = "GroupsViewControllerCell"
    
    var viewModel: GroupsViewControllerCellViewModelType? {
        willSet(viewModel){
            self.textLabel!.text = "\(viewModel?.groupName ?? "fuck off") / \(viewModel?.subgroupNumb ?? 9999)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
