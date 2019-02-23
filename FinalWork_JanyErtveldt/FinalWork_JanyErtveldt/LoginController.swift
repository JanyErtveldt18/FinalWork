//
//  LoginController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 14/01/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import GeoFire
import FirebaseFirestore

class LoginController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var profielImage: UIImageView!
    
    var menuShowing = false
    var alleVerdwaaldeKinderen = [Kind]()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("Viewdidload")
        print(menuShowing)
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        self.profielImage.layer.cornerRadius = self.profielImage.frame.size.width / 2;
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        db.collection("VerdwaaldeKinderen").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for kinderen in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        //print("\(kinderen.data()["NaamKind"]!)")
                        //print("\(kinderen.data())")
                        
                        /*
                         var id: Int?
                         var naamOuder: String?
                         var voornaamOuder: String?
                         var naamKind: String?
                         var voornaamKind: String?
                         var beschrijving: String?
                         var leeftijd: Int?
                         */
                        let kindId  = kinderen.data()["Id"]!
                        let naamKind  = kinderen.data()["NaamKind"]!
                        let voornaamKind  = kinderen.data()["VoornaamKind"]!
                        let naamOuder  = kinderen.data()["NaamOuder"]!
                        let voornaamOuder  = kinderen.data()["VoornaamOuder"]!
                        let beschrijving  = kinderen.data()["Beschrijving"]!
                        let leeftijd  = kinderen.data()["Leeftijd"]!
                        print("KindID voor ieder kind: ",kindId)
                        
                        let kind = Kind(id: kindId as? String, naamOuder: naamOuder as? String, voornaamOuder: voornaamOuder as? String, naamKind: naamKind as? String, voornaamKind: voornaamKind as? String, beschrijving: beschrijving as? String, leeftijd: leeftijd as? Int)
                        self.alleVerdwaaldeKinderen.append(kind)
                        for(index,kind) in self.alleVerdwaaldeKinderen.enumerated() {
                            print(index)
                            print(kind.naamKind!)
                        }
                    }
                }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "HOME"
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        print("User logout")
        try! Auth.auth().signOut()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! ViewController
                self.present(vc,animated: true,completion: nil)
    }
    
    @IBAction func openInfoMenu(_ sender: Any) {
        print("menuShowing")
        print(menuShowing)
        if(menuShowing){
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.tabBarController?.tabBar.isHidden = true
            })
        }else{
            
            leadingConstraint.constant = 375
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = false
            })
            
            
        }
        menuShowing = !menuShowing
    }
    
}
