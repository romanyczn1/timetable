//
//  TabBarController.swift
//  timetable
//
//  Created by Roman Bukh on 9/13/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    var viewModel: TabBarControllerViewModelType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewModel = TabBarControllerViewModel()
        
    }
}
