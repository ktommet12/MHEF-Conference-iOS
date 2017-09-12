//
//  ParkingInfoViewController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 9/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ParkingInfoViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var parkingScrollView: UIScrollView!
    @IBOutlet weak var parkingImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkingScrollView.delegate = self
        
        AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)

       
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.parkingImg
    }

}
