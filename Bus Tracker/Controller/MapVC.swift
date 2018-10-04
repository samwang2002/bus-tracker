//
//  MapVC.swift
//  Bus Tracker
//
//  Created by Sam Wang  on 9/23/18.
//  Copyright © 2018 Sam Wang. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initTrackingButton()
        
    }
    
    @IBAction func onSettingsButtonPressed(_ sender: UIBarButtonItem) {
        
        let settingsAlert = UIAlertController(title: "Settings", message: "", preferredStyle: .alert)
        settingsAlert.addAction(UIAlertAction(title: "Login as driver", style: .default, handler: { action in
            self.loginAsDriver()
        }))
        settingsAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(settingsAlert, animated: true)
        
    }
    
    func loginAsDriver() {
        
        let loginAlert = UIAlertController(title: "Login as driver", message: "Enter ID and passcode to login", preferredStyle: .alert)
        
        loginAlert.addTextField { (textField) in
            textField.placeholder = "ID"
        }
        loginAlert.addTextField { (textField) in
            textField.placeholder = "Passcode"
            textField.isSecureTextEntry = true
        }
        
        loginAlert.addAction(UIAlertAction(title: "Login", style: .default, handler: nil))
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(loginAlert, animated: true)
        
    }
    
    func initTrackingButton() {
        
        let trackingLocationButton: UIBarButtonItem = MKUserTrackingBarButtonItem(mapView: map)
        navigationItem.leftBarButtonItem = trackingLocationButton
        map.userTrackingMode = .follow
        
    }
    
}
