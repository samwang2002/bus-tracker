//
//  DriverVC.swift
//  Bus Tracker
//
//  Created by Sam Wang  on 10/10/18.
//  Copyright © 2018 Sam Wang. All rights reserved.
//

import UIKit
import MapKit

class DriverVC: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        map.setUserTrackingMode(.follow, animated: true)
        
    }

}
