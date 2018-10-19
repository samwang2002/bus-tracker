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

class MapVC: UIViewController, CLLocationManagerDelegate, DBHandler {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegue(withIdentifier: "UserToDriverSegue", sender: nil)
        requestAndShowLocation()
        initTrackingButton()
        //initBackButton()
        
    }
    
    @IBAction func onSettingsButtonPressed(_ sender: UIBarButtonItem) {
        
        let settingsAlert = UIAlertController(title: "Settings", message: "", preferredStyle: .alert)
        settingsAlert.addAction(UIAlertAction(title: "Login as driver", style: .default, handler: { action in
            self.loginAsDriverPopup()
        }))
        settingsAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(settingsAlert, animated: true)
        
    }
    
    func requestAndShowLocation() {
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        map.setUserTrackingMode(.follow, animated: true)
        
        if locationManager.location == nil {
            
            let locationNotEnabledAlert = UIAlertController(title: "Cannot detect location", message: "Please make sure location services are enabled", preferredStyle: .alert)
            
            locationNotEnabledAlert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (alert: UIAlertAction) in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                
            }))
            
            locationNotEnabledAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(locationNotEnabledAlert, animated: true)
            
        }
        
    }
    
    func initTrackingButton() {
        
        let trackingLocationButton: UIBarButtonItem = MKUserTrackingBarButtonItem(mapView: map)
        navigationItem.leftBarButtonItem = trackingLocationButton
        
    }
    
    func initBackButton() {
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        
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
            // segue to driver view
            performSegue(withIdentifier: "UserToDriverSegue", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // create back button
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
    }
    
    func updateBusLocation(bus: String, location: CLLocation) {
        
        
        
    }
    
}
