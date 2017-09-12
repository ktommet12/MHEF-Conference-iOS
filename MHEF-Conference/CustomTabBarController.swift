//
//  CustomTabBarController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/22/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var currentConference: Conference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        super.delegate = self
        
        
        //create the default schedule with not filters or favorites
        let vc1 = storyboard.instantiateViewController(withIdentifier: "ScheduleController") as! ScheduleController
        vc1.currentConference = currentConference
        vc1.isScheduleSelected = true
        vc1.tabBarItem.image = UIImage(named: "schedule icon")
        vc1.tabBarItem.title = "Schedule"
        
        let vc2 = storyboard.instantiateViewController(withIdentifier: "ScheduleController") as! ScheduleController
        vc2.currentConference = currentConference
        vc2.isFavoritesSelected = true
        vc2.tabBarItem.image = UIImage(named: "schedule icon")
        vc2.tabBarItem.title = "Favorites"
        
//        let vc3 = storyboard.instantiateViewController(withIdentifier: "ScheduleController") as! ScheduleController
//        vc3.currentConference = currentConference
//        vc3.isFilterSelected = true
//        let tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 2)
//        tabBarItem.title = "Filter"
//        vc3.tabBarItem = tabBarItem
        
        
        //let navigationController = UINavigationController(rootViewController: scheduleController)

        
        viewControllers = [vc1, vc2]
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let vc:ScheduleController = viewController as! ScheduleController
        vc.refreshViews()
    }

}
