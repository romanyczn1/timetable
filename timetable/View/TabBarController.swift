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
    var arrayOfImageNameForSelectedState: [String] = ["scheduleIcon", "settingsIcon"]
    var arrayOfImageNameForUnselectedState: [String] = ["scheduleIcon", "settingsIcon"]
    var titles: [String] = ["Schedule", "Setting"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewModel = TabBarControllerViewModel()
        setUpTabBarItems()
    }
    
    private func setUpTabBarItems(){
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]

                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].title = titles[i]
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }

        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
}
