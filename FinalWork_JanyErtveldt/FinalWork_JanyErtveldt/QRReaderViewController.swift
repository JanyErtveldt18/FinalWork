//
//  QRReaderViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 10/02/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import MapKit

class QRReaderViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var ScanVierkant: UIImageView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var video = AVCaptureVideoPreviewLayer()
    var stringWaarde = String()
    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creating session
        let session = AVCaptureSession()
        
        //Define capture device
        //Camera output is gedeinieerd als captureDevice
        let captureDevice =  AVCaptureDevice.default(for: .video)
        
        //Camera output (wat de gebruiker ziet) in de session plaatsen
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print("Er is een error plaatsgevonden, gelieve de app te herstarten!");
        }
        
        //Van het beeld output nemen om QR-codes te kunnen herkennen
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //HIER KAN HET FOUT ZIJN in video 9:17
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        //Video neemt heel scherm over
        video.frame = view.layer.bounds
        
        
        view.layer.addSublayer(video)
        self.view.bringSubviewToFront(ScanVierkant)
        
        session.startRunning()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "QR-SCANNER"
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    stringWaarde = machineReadableCode.stringValue!
                    let alert = UIAlertController(title: "QR-code gescand", message: "Toon route naar ouders", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Scan opnieuw", style: .default, handler: nil))
                    
                    let openKaart = UIAlertAction(title: "Toon route", style: .default, handler: {(action) -> Void in
                        
                        let KaartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Kaart") as! KaartViewController
//                        KaartViewController.meegekregenCode = self.stringWaarde
                        
                        //opent app maps op iPhone dus gaat uit de applicatie
                        //Eindpunt locatie
//                        let latitude: CLLocationDegrees = 50.872667
//                        let longitude: CLLocationDegrees = 4.248144
//
//                        let regionDistance: CLLocationDistance = 1000
//                        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//                        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//
//                        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
//
//                        let placemark = MKPlacemark(coordinate: coordinates)
//                        let mapItem = MKMapItem(placemark: placemark)
//                        mapItem.name = "Locatie kind"
//                        mapItem.openInMaps(launchOptions: options)
                        
                        
                        
                        self.present(KaartViewController, animated: true, completion: nil)
                    })
                    alert.addAction(openKaart)
                    
                    
                    
                    
                    /*
                     let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewControllerID") as! DetailViewController
                     //let test = detailViewController.viewControllers![0] as! ProfielViewController
                     
                     self.present(detailViewController, animated: true, completion: nil)
                     
                     */
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    present(alert,animated: true,completion: nil)
                    
                
                    
//                    performSegue(withIdentifier: "Homesceen", sender: self)
                    print(stringWaarde)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Homesceen" {
            let destination = segue.destination as! LoginController
            
        }
    }
    
    
   
}
