//
//  DriverVC.swift
//  Bus Tracker
//
//  Created by Sam Wang  on 10/10/18.
//  Copyright © 2018 Sam Wang. All rights reserved.
//

import UIKit
import MapKit

class DriverVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var locationManager: CLLocationManager!
    let busNumber = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        initTrackingButton()
        map.setUserTrackingMode(.follow, animated: true)
        
    }

    func initTrackingButton() {
        
        let trackingLocationButton: UIBarButtonItem = MKUserTrackingBarButtonItem(mapView: map)
        navigationItem.rightBarButtonItem = trackingLocationButton
        
    }
    
    @IBAction func onToggleTripButtonPressed(_ sender: UIBarButtonItem) {
        
        if sender.title == "Begin trip" {
            
            sender.title = "End trip"
            
            // initialize location manager
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.activityType = .automotiveNavigation
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            print(map.userLocation.coordinate)
            
        } else {
            
            sender.title = "Begin trip"
            locationManager.stopUpdatingLocation()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("location updated")
        
        if let currentLocation = locations.last {
            print("\(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")
            DBReference.Instance.updateBusLocation(bus: "\(busNumber)", location: currentLocation)
        }
        
    }
    
}
