//
//  AppDelegate.swift
//  timetable
//
//  Created by Roman Bukh on 8/29/20.
//  Copyright © 2020 Roman Bukharin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if window != nil {
            if let tabBar = window?.rootViewController as? TabBarController{
                if let controller = tabBar.viewControllers![0] as? ScheduleViewController {
                    controller.viewModel?.goToStartDate(completion: {
                        DispatchQueue.main.async {
                            controller.deleteUnnecessarySubviews()
                            controller.headerView.viewModel = controller.viewModel!.headerViewViewModel()
                            controller.selectedDayView.viewModel = controller.viewModel!.selectedDayViewViewModel()
                            controller.collectionView.reloadData()
                            controller.tableView.reloadData()
                        }
                    })
                }
            }
        }
    }
    
}

