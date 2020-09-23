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
    var arrayOfImageNameForSelectedState: [String] = ["calendar", "settings"]
    var arrayOfImageNameForUnselectedState: [String] = ["calendar", "settings"]
    var titles: [String] = ["Schedule", "Settings"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewModel = TabBarControllerViewModel()
        setUpTabBarItems()
        if let controller = viewControllers![0] as? ScheduleViewController {
            controller.viewModel = viewModel?.viewControllerViewModel()
        }
    }
    
    private func setUpTabBarItems(){
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]

                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysTemplate)
                self.tabBar.items?[i].title = titles[i]
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysTemplate)
            }
        }

        let selectedColor   = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        var unselectedColor = UIColor()
        if #available(iOS 13.0, *) {
            unselectedColor = UIColor.label
        } else {
            unselectedColor = .gray
        }

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
}
