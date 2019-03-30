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
import MessageUI

class QRReaderViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,MFMessageComposeViewControllerDelegate {
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
                    
                    
                    let openKaart = UIAlertAction(title: "Open route app", style: .default, handler: {(action) -> Void in
                        //Waarde achter QR-code
                        print(self.stringWaarde)
                        
                        //QR-code door database halen
                        //Degene die gelijk is gegevens ouders ophalen - locatie
                        //Bericht naar gsm nummer sturen - open applicatie voor locatie gebruik voor route
                        
                        //Ouders open app en locatie wordt opgevraagd
                        
                        
                        //opent app maps op iPhone dus gaat uit de applicatie
                        //Eindpunt locatie ouders
                        let latitude: CLLocationDegrees = 50.872667
                        let longitude: CLLocationDegrees = 4.248144

                        let regionDistance: CLLocationDistance = 1000
                        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)

                        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]

                        let placemark = MKPlacemark(coordinate: coordinates)
                        let mapItem = MKMapItem(placemark: placemark)
                        mapItem.name = "Locatie ouders"
                        mapItem.openInMaps(launchOptions: options)
                        
                        
                        
                        //self.present(KaartViewController, animated: true, completion: nil)
                    })
                    alert.addAction(openKaart)
                    
                    let belOudersVerdwaaldKind = UIAlertAction(title: "BEL OUDERS", style: .default, handler: {(action) -> Void in
                        print("Bel GSM-nummer ouders")
                        //GSM nummer nog ophalen uit firebase db
//                        let url:NSURL = NSURL(string: "tel://0486107709")!
//                        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                        
                        
                        //SMS sturen naar nummer
                        let messageVC = MFMessageComposeViewController()
                        
                        messageVC.body = "Hello, I found your child. Can you please go to the ...... app, so I can locate you on the map and start a route to you.";
                        messageVC.recipients = ["0471066840"]
                        messageVC.messageComposeDelegate = self
                        
                        self.present(messageVC, animated: true, completion: nil)
                    })
                    alert.addAction(belOudersVerdwaaldKind)
                    
                    present(alert,animated: true,completion: nil)
                 
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
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
   
}
