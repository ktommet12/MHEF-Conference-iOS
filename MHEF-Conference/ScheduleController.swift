//
//  ScheduleController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/16/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ScheduleController: ButtonBarPagerTabStripViewController  {
    
    //this will be used when generating the table in order to determine which talks to show
    var isScheduleSelected:  Bool = false
    var isFavoritesSelected: Bool = false
    var isFilterSelected:    Bool = false //unused currently (as of Tue Sept 5th, 2017)
    
    @IBOutlet weak var btnFavorites: UIButton!
    @IBOutlet weak var btnSchedule: UIButton!
    
    var currentConference: Conference!
    
    let purpleInspireColor = UIColor(red: 0.13, green: 0.03, blue: 0.25, alpha: 1.0)
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = AppConfig.EVOLUTION_BLUE_COLOR
        settings.style.buttonBarItemBackgroundColor = AppConfig.EVOLUTION_BLUE_COLOR
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        if isFavoritesSelected{
            btnSchedule.backgroundColor = .white
            btnSchedule.setTitleColor(AppConfig.EVOLUTION_BLUE_COLOR, for: .normal)
            btnFavorites.backgroundColor = AppConfig.EVOLUTION_BLUE_COLOR
            btnFavorites.setTitleColor(.white, for: .normal)
        }
        if isScheduleSelected{
            btnFavorites.setTitleColor(AppConfig.EVOLUTION_BLUE_COLOR, for: .normal)
            btnFavorites.backgroundColor = .white
            btnSchedule.setTitleColor(.white, for: .normal)
            btnSchedule.backgroundColor = AppConfig.EVOLUTION_BLUE_COLOR
        }
        
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .white
            newCell?.label.textColor = .black
        }
        
    
        print("ScheduleController viewDidLoad")
        
        super.viewDidLoad()
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let test = sender as? UIButton{
            if test.accessibilityLabel! == "goHome"{
                return true
            }
        }
        if identifier == "showScheduleFromFavorites" && isFavoritesSelected{
            return true
        }
        else if identifier == "showFavoritesFromSchedule" && isScheduleSelected{
            return true
        }
        else if identifier == "unwindToLandingSegue"{
            return true
        }
        else{
            return false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScheduleFromFavorites"{
            let vc = segue.destination as! ScheduleController
            vc.currentConference = currentConference
            vc.isScheduleSelected = true
        }
        if segue.identifier == "showFavoritesFromSchedule"{
            let vc = segue.destination as! ScheduleController
            vc.currentConference = currentConference
            vc.isFavoritesSelected = true
        }
        
    }
    @IBAction func unwindToSchedule(segue: UIStoryboardSegue){}
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        print("ScheduleController View Controllers Called")
        let dates = currentConference.getConferenceDates()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controllers = [UIViewController]()
        
        for date in dates{
            
            let vc: ScheduleDayController = storyboard.instantiateViewController(withIdentifier: "ScheduleDayController") as! ScheduleDayController
            
            vc.talkDayString = date
            
            let tempCurrentDayTalks = currentConference.getAllTalks(forDay: date, isFavorites: isFavoritesSelected)
            
            vc.currentDayTalks = tempCurrentDayTalks
            vc.currentConference = currentConference
            vc.isFavoritesSelected = self.isFavoritesSelected
            
            controllers.append(vc)
        }
        return controllers
    }
    func refreshViews(){
        //super.viewDidLoad()
        //super.viewWillAppear(false)
    }

}
