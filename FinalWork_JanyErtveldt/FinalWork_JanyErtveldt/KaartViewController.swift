//
//  KaartViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 12/02/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class KaartViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    //Map
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    var latitudeUser = String("")
    var longitudeUser = String("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapview: MKMapView, didUpdate userLocation: MKUserLocation){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center,span: span)
        mapview.setRegion(region,animated: true)
        self.map.showsUserLocation = true
        
        latitudeUser = "\(userLocation.coordinate.latitude)"
        longitudeUser = "\(userLocation.coordinate.longitude)"
        print("LatitudeUser: " + latitudeUser)
        print("LongitudeUser: " + longitudeUser)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
