//
//  DetailKindViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 09/04/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GeoFire
import FirebaseFirestore
import CoreData
import CoreLocation

class DetailKindViewController: UIViewController {
    var naamKind:String?
    var voornaamKind:String?
    var leeftijdKind:String?
    var beschrijvingKind:String?
    var naamOuders:String?
    var laatst_gezien:String?
    
    var imagereference:String?
    
    @IBOutlet weak var btnCallToChildFocus: UIButton!
    
    @IBOutlet weak var lblVoornaamKind: UILabel!
    @IBOutlet weak var lblNaamKind: UILabel!
    @IBOutlet weak var lblLeeftijdKind: UILabel!
    @IBOutlet weak var lblBeschrijvingKind: UILabel!
    @IBOutlet weak var lblNaamOuders: UILabel!
    @IBOutlet weak var lbllaatst_gezien: UILabel!
    @IBOutlet weak var imageviewKind: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCallToChildFocus.layer.cornerRadius = 10.0
       // self.lblVoornaamKind.text = "Voornaam kind: " + voornaamKind!
        self.lblNaamKind.text = "Naam: " + naamKind!+" " + voornaamKind!
        self.lblLeeftijdKind.text =  leeftijdKind! + " jaar"
        self.lblBeschrijvingKind.text = beschrijvingKind
        self.lblNaamOuders.text = "Naam ouders: " + naamOuders!
        self.lbllaatst_gezien.text = "Laatst gezien: " + laatst_gezien!
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let reference = storageRef.child(imagereference!)
        reference.getData(maxSize: 1 * 3072 * 3072) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
                print("doesnt work")
            } else {
                let image = UIImage(data: data!)
                print(data!)
                self.imageviewKind.image = image
                
            
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func belChildFocus(_ sender: UIButton) {
        let url:NSURL = NSURL(string: "tel://024754411")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    

}
