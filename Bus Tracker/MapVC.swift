//
//  MapVC.swift
//  Bus Tracker
//
//  Created by Sam Wang  on 9/23/18.
//  Copyright © 2018 Sam Wang. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapVC: UIViewController, DBHandler {

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
            self.loginAsDriverPopup()
        }))
        settingsAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(settingsAlert, animated: true)
        
    }
    
    func initTrackingButton() {
        
        let trackingLocationButton: UIBarButtonItem = MKUserTrackingBarButtonItem(mapView: map)
        navigationItem.leftBarButtonItem = trackingLocationButton
        map.setUserTrackingMode(.follow, animated: true)
        print("tracking mode = \(map.userTrackingMode)")
        print("shows user location = \(map.showsUserLocation)")
        //map.userTrackingMode = .follow
        
    }
    
    func loginAsDriverPopup() {
        
        let loginAlert = UIAlertController(title: "Login as driver", message: "Enter ID to login", preferredStyle: .alert)
        
        loginAlert.addTextField { (textField) in
            textField.placeholder = "ID"
        }
        
        loginAlert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (alert: UIAlertAction!) in
            self.loginAsDriver(enteredKey: loginAlert.textFields![0].text!)
        }))
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(loginAlert, animated: true)
        
    }
    
    func loginAsDriver(enteredKey: String) {
        
        if enteredKey == Constants.key {
            print("correct!")
        }
        
    }
    
}
