//
//  LocationSingleton.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 16/02/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import GeoFire
import CoreLocation
import Firebase
import FirebaseDatabase
import FirebaseAuth

// how to create singleton

class Singleton: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    // MARK: - Shared Instance
    var geoFire: GeoFire?
    
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        instance.configureLocationManager()
        var geoFireRef: DatabaseReference?
        geoFireRef = Database.database().reference().child("Geolocs")
        //
        instance.geoFire = GeoFire(firebaseRef: geoFireRef!)
        
        
        return instance
    }()
    
    func configureLocationManager(){
        
        if #available(iOS 9.0, *) {
            manager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = false
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        if (status == .authorizedAlways) || (status == .authorizedWhenInUse)
        {
            manager.startUpdatingLocation()
            
            
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Location Error:\(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        
        
        let updatedLocation:CLLocation = locations.first!
        
        let newCoordinate: CLLocationCoordinate2D = updatedLocation.coordinate
        
        let usrDefaults:UserDefaults = UserDefaults.standard
        
        print(newCoordinate)
        
        usrDefaults.set("\(newCoordinate.latitude)", forKey: "current_latitude")
        usrDefaults.set("\(newCoordinate.longitude)", forKey: "current_longitude")
        usrDefaults.synchronize()
        
        let location:CLLocation = CLLocation(latitude: CLLocationDegrees(Double("\(newCoordinate.latitude)")!), longitude: CLLocationDegrees(Double("\(newCoordinate.longitude)")!))
        
        geoFire?.setLocation(location, forKey:(Auth.auth().currentUser?.uid)!)
        print(geoFire)
        print("na database input")
        let test = Auth.auth().currentUser!.uid
        print(test)
        //self.ref.child("users/\(user.uid)/username").setValue(username)
    }
    
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
}
