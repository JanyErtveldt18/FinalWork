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
import CoreData
//laadPolitiekantorenDataIn()
class KaartViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    let urlRequest = URLRequest(url: URL(string: "https://opendata.brussel.be/api/records/1.0/search/?dataset=politiekantoren")!)
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    let locationManager = CLLocationManager()
    
    //Map
    @IBOutlet weak var map: MKMapView!
    
    
    var latitudeUser = String("")
    var longitudeUser = String("")
    
    var opgehaaldePolitiekantoren:[Politiekantoor] = []
    
    var zoomin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.tintColor = UIColor.red
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore  {
            print("self.haalGegevensOp()")
            self.haalGegevensOp()
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            print("self.toonGegevens()")
            self.toonGegevens()
            
        }
        
       
    }
    
    
    //ZOOMT IEDERE KEER IN OP USERLOCATION BIJ KLEINSTE BEWEGING
    
//    func mapView(_ mapview: MKMapView, didUpdate userLocation: MKUserLocation){
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center,span: span)
//        mapview.setRegion(region,animated: true)
////        self.map.showsUserLocation = true
//    }
    
    
    func mapView(_ mapview: MKMapView, didUpdate userLocation: MKUserLocation){
        if zoomin == true{
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
                    let region = MKCoordinateRegion(center: center,span: span)
                    mapview.setRegion(region,animated: true)
            zoomin = false
        }
        else{
            print("nope")
        }
    }
    
    

    func toonGegevens(){
        DispatchQueue.main.async {
            let politieFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Politiekantoren")
            let opgehaaldePolitiekantoren:[Politiekantoren]
            do{
                opgehaaldePolitiekantoren = try self.managedContext?.fetch(politieFetch) as! [Politiekantoren]
                
                for politie in opgehaaldePolitiekantoren{
                    let coordinate = CLLocationCoordinate2D(latitude: politie.latitude, longitude: politie.longitude)
                    let x = Politiekantoor_Annotation(title: politie.name,subtitle: politie.adres, coordinate: coordinate)
                    self.map.addAnnotation(x)
                    
                }
            } catch{
                fatalError("De gegevens konden niet worden opgehaald: \(error)")
            }
        }
    }
    
    
    func haalGegevensOp(){
//        let task = session.dataTask(with: urlRequest) {(data, response, error) in
//            guard error == nil else{
//
//                print("kon get functie niet aanroepen")
//                print(error!)
//                return
//            }
//
//            guard let responseData = data else {
//                print("Error: geen data ontvangen")
//                return
//            }
//            print(responseData)
        
        guard let path = Bundle.main.path(forResource: "politiekantoren", ofType: "txt") else{ return }
        let url = URL(fileURLWithPath: path)
            
            do{
                let responseData = try Data(contentsOf: url)
                let politieData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [AnyObject]
                //print(politieData!)
                for data in politieData! {
                    DispatchQueue.main.async {
                        //let positie = data["position"] as! NSDictionary
                        
                        let Politiekantoor = NSEntityDescription.insertNewObject(forEntityName: "Politiekantoren", into: self.managedContext!) as! Politiekantoren
                        
                        Politiekantoor.name = data["naam"] as? String
                        Politiekantoor.adres = data["adres"] as? String
                        Politiekantoor.latitude = data["latitude"] as! Double
                        Politiekantoor.longitude = data["longitude"] as! Double
                        Politiekantoor.icon = data["icon"] as? String
                        
                        do{
                            try self.managedContext?.save()
                        } catch{
                            fatalError("kon context niet opslaan: \(error)")
                        }
                    }
                }
               self.toonGegevens()
//                self.updateTijd()
            } catch {
                print(error)
            }
//        task.resume()
        
    }
    
    
   
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation")
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Politie")
        
            
            annotationView?.image = UIImage(named: "Politie")
            let calloutButton = UIButton(type: .infoDark)
            annotationView!.rightCalloutAccessoryView = calloutButton
            annotationView!.sizeToFit()
        }
        if annotation is MKUserLocation {

            return nil
        }
        annotationView?.canShowCallout = true
        
        if annotation.title == "Reddingspost Treintje"{
            annotationView?.image = UIImage(named: "Treintje")
        }
        if annotation.title == "Reddingspost Bal"{
            annotationView?.image = UIImage(named: "Bal")
        }
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            print("Klik")
            let alertController = UIAlertController(title: "ROUTE STARTEN", message: "Opent standaard app KAARTEN voor route naar politiekantoor", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            let openKaart = UIAlertAction(title: "Start route", style: .destructive, handler: {(action) -> Void in
                // opent app maps op iPhone dus gaat uit de applicatie
                let latitude: CLLocationDegrees = (view.annotation?.coordinate.latitude)!
                let longitude: CLLocationDegrees = (view.annotation?.coordinate.longitude)!
                
                let regionDistance: CLLocationDistance = 1000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
                
                let placemark = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = view.annotation?.title ?? "Politiekantoor"
                mapItem.openInMaps(launchOptions: options)
                
                
                
                //self.present(KaartViewController, animated: true, completion: nil)
            })
            alertController.addAction(openKaart)

            self.present(alertController, animated: true, completion: nil)
            
//            let alert = UIAlertController(title: "ROUTE STARTEN", message: "route naar politiekantoor", preferredStyle: .alert)
//
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
}
