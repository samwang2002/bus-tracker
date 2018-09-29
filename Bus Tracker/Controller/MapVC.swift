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
    
    private var followingUserLocation = true
    
    private lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = CLActivityType.automotiveNavigation
        return _locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initLocationManager()
        navigationItem.title = "Bus Tracker"
        
    }
    
    @IBAction func pinchGestureDetected(_ sender: UIPinchGestureRecognizer) {
        followingUserLocation = false
    }
    
    @IBAction func rotationGestureDetected(_ sender: UIRotationGestureRecognizer) {
        followingUserLocation = false
    }
    
    @IBAction func panGestureDetected(_ sender: UIPanGestureRecognizer) {
        followingUserLocation = false
    }
    
    func initLocationManager() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func initNavBar() {
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if followingUserLocation {
            
            if let location = locationManager.location?.coordinate {
                
                print("\(location.latitude) \(location.longitude)")
                let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
                map.setRegion(region, animated: true)
                
            }
            
        }
    }
    
}
