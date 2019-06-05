//
//  ProfielViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 07/05/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfielViewController: UIViewController {

    @IBOutlet weak var lblNaamOuder: UILabel!
    @IBOutlet weak var lblVoornaamOuder: UILabel!
    @IBOutlet weak var lblAdresOuder: UILabel!
    @IBOutlet weak var lblGsmOuder: UILabel!
    
    @IBOutlet weak var lblNaamKind: UILabel!
    @IBOutlet weak var lblVoornaamKind: UILabel!
    @IBOutlet weak var lblLeeftijdKind: UILabel!
    @IBOutlet weak var lblBeschrijvingKind: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.haalGegevensUserOp()
        //printUser()
        // Do any additional setup after loading the view.
    }
    
//    func printUser(){
//        print((Auth.auth().currentUser?.uid)!)
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.haalGegevensUserOp()
        print("tadaaaaaa")
    }

    
    func haalGegevensUserOp(){
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        let docRef = db.collection("Users").document((Auth.auth().currentUser?.uid)!)
        
        docRef.getDocument { (document, error) in
            if let gegeven = document, document!.exists {
                self.lblNaamOuder.text = gegeven.data()!["lastname"]! as? String
                self.lblVoornaamOuder.text = gegeven.data()!["name"]! as? String
                self.lblAdresOuder.text = "\(gegeven.data()!["adress"]!) " + "\(gegeven.data()!["postcode"]!) " + "\(gegeven.data()!["gemeente"]!)"
                self.lblGsmOuder.text = gegeven.data()!["gsm"]! as? String
                self.lblNaamKind.text = gegeven.data()!["lastnamechild"]! as? String
                self.lblVoornaamKind.text = gegeven.data()!["firstnamechild"]! as? String
                self.lblLeeftijdKind.text = gegeven.data()!["leeftijdChild"]! as? String
                self.lblBeschrijvingKind.text = gegeven.data()!["beschrijvingchild"]! as? String
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    

    @IBAction func uitloggenUser(_ sender: UIButton) {
        print("User logout")
        try! Auth.auth().signOut()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! ViewController
        self.present(vc,animated: true,completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editProfielViewcontroller = segue.destination as! EditProfielViewController
        editProfielViewcontroller.naam = lblNaamOuder.text
        editProfielViewcontroller.voornaam = lblVoornaamOuder.text
        editProfielViewcontroller.adres = lblAdresOuder.text
        editProfielViewcontroller.gsm = lblGsmOuder.text
        editProfielViewcontroller.naamKind = lblNaamKind.text
        editProfielViewcontroller.voornaamKind = lblVoornaamKind.text
        editProfielViewcontroller.leeftijdKind = lblLeeftijdKind.text
        editProfielViewcontroller.beschrijvingKind = lblBeschrijvingKind.text
    }
}
