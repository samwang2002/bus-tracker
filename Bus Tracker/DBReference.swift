//
//  DBReference.swift
//  Bus Tracker
//
//  Created by Sam Wang  on 10/7/18.
//  Copyright © 2018 Sam Wang. All rights reserved.
//

import Foundation
import MapKit
import FirebaseDatabase

class DBReference {
    
    private var ref: DatabaseReference!
    private var delegate: DBHandler!
    
//    private var key: String?
    
    static let Instance: DBReference = {
        
        let _instance = DBReference()
        return _instance
        
    }()
    
    init() {
        
        ref = Database.database().reference()
        
    }
    
    func updateBusLocation(bus: String, location: CLLocation) {
        
        ref.child(bus).setValue([Constants.lat : location.coordinate.latitude, Constants.long : location.coordinate.longitude])
        
    }
    
    func observeBusLocationUpdate(bus: String) {
        
        ref.child(bus).observe(.value, with: { (snapshot: DataSnapshot) in
            
            guard let locationDict = snapshot.value as? [String : Any] else {
                return
            }
            
            guard let latitude = locationDict[Constants.lat] as? CLLocationDegrees else {
                return
            }
            
            guard let longitude = locationDict[Constants.long] as? CLLocationDegrees else {
                return
            }
            
            let busLocation = CLLocation(latitude: latitude, longitude: longitude)
            self.delegate.updateBusLocation(bus: bus, location: busLocation)
            
        })
        
    }
    
//    func fetchKey() {
//
//        ref.observe(.value, with: { (snapshot: DataSnapshot) in
//
//            if let value = snapshot.value as? [String: String] {
//                self.key = value[DBConstants.key]!
//                print("received key is \(self.key!)")
//                self.delegate.retrieveKey()
//            } else {
//                print("snapshot not accesible")
//            }
//
//        })
//
//    }
//
//    func getKey() -> String? {
//
//        return key
//
//    }
//
    
}

protocol DBHandler {
    
    func updateBusLocation(bus: String, location: CLLocation)
    
}
