//
//  EditProfielViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 25/05/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class EditProfielViewController: UIViewController {
    @IBOutlet weak var txtEditNaam: UITextField!
    @IBOutlet weak var txtEditVoornaam: UITextField!
    
    @IBOutlet weak var lblAdres: UILabel!
    @IBOutlet weak var lblGsm: UILabel!
    @IBOutlet weak var lblNaamKind: UILabel!
    @IBOutlet weak var lblVoornaamKind: UILabel!
    @IBOutlet weak var lblLeeftijdKind: UILabel!
    @IBOutlet weak var lblBeschrijvingKind: UILabel!
    
    var naam:String?
    var voornaam:String?
    
    var adres:String?
    var gsm:String?
    
    var naamKind:String?
    var voornaamKind:String?
    var leeftijdKind:String?
    var beschrijvingKind:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEditNaam.text = naam
        txtEditVoornaam.text = voornaam
        
        lblAdres.text = adres
        lblGsm.text = gsm
        lblNaamKind.text = naamKind
        lblVoornaamKind.text = voornaamKind
        lblLeeftijdKind.text = leeftijdKind
        lblBeschrijvingKind.text = beschrijvingKind
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
       // self.txtEditNaam.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEditNaam.resignFirstResponder()
        return(true)
    }
    
    @IBAction func btnInfoEditen(_ sender: Any) {
        let alert = UIAlertController(title: "Kan niet worden aangepast", message: "Wilt u één van deze gegevens aanpassen, vraag dit aan het Toerimsebureau of de Kustreddingsdienst.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Terug", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    
    
    

    @IBAction func btnSaveUser(_ sender: UIButton) {
        let dict: [String:Any] = ["name":txtEditNaam.text,"lastname":txtEditVoornaam.text]
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        db.collection("Users").document((Auth.auth().currentUser?.uid)!).updateData(dict)
        
        
    }
    
    
    
}
