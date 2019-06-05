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
import CoreData
import CoreLocation

class LoginController: UIViewController {
    
    @IBOutlet weak var kindScrollView: UIScrollView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var profielImage: UIImageView!
    
    var menuShowing = false
    var alleVerdwaaldeKinderen = [Kind]()
    
    
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        self.profielImage.layer.cornerRadius = self.profielImage.frame.size.width / 2;
        
        self.haalAllesOpVanDatabase()
    }
    
    func haalAllesOpVanDatabase(){
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        db.collection("VerdwaaldeKinderen").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for kinderen in querySnapshot!.documents {
                    
                    let kindId  = kinderen.data()["Id"]!
                    let naamKind  = kinderen.data()["NaamKind"]!
                    let voornaamKind  = kinderen.data()["VoornaamKind"]!
                    let naamOuder  = kinderen.data()["NaamOuder"]!
                    let voornaamOuder  = kinderen.data()["VoornaamOuder"]!
                    let beschrijving  = kinderen.data()["Beschrijving"]!
                    let relatie  = kinderen.data()["Relatie"]!
                    let leeftijd  = kinderen.data()["Leeftijd"]!
                    let url  = kinderen.data()["url"]!
                    let laatst_gezien = kinderen.data()["laatst_gezien"]!
                    let vermist_sinds = kinderen.data()["vermist_sinds"]!
                    //print("KindID voor ieder kind: ",kindId)
                    
                    let kind = Kind(id: kindId as? String, naamOuder: naamOuder as? String, voornaamOuder: voornaamOuder as? String, relatie: relatie as? String, naamKind: naamKind as? String, voornaamKind: voornaamKind as? String, beschrijving: beschrijving as? String, leeftijd: leeftijd as? Int,url:url as? String, laatst_gezien: laatst_gezien as? String, vermist_sinds: vermist_sinds as? String)
                    self.alleVerdwaaldeKinderen.append(kind)
                }
                self.zetAllesOpDeHomepagina()
            }
        }
    }
    
    func maakAllesLeegEerst(){
        //Core data legen want anders blijven de kinderen iedere keer opslaan
        var alleVerdwaaldeKinderenTest = [VerdwaaldKind]()
        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "VerdwaaldKind")
        do{
            alleVerdwaaldeKinderenTest = try managedContext?.fetch(stationFetch) as! [VerdwaaldKind]

            if (alleVerdwaaldeKinderenTest.count) > 0{
                print("verwijder eerst alles")
                for verdwaaldKind in alleVerdwaaldeKinderenTest{
                    managedContext?.delete(verdwaaldKind)
                    try! managedContext?.save()
                }
                
            }else{
                print("niets te verwijderen")
            }

        }catch{

        }
    }
    
    func zetAllesOpDeHomepagina(){
        maakAllesLeegEerst()
        print(alleVerdwaaldeKinderen.count)
        for(index,kind) in self.alleVerdwaaldeKinderen.enumerated() {
            let nieuweverdwaaldkind = NSEntityDescription.insertNewObject(forEntityName: "VerdwaaldKind", into: managedContext!)
            nieuweverdwaaldkind.setValue(kind.naamKind!, forKey: "naamKind")
            nieuweverdwaaldkind.setValue(kind.voornaamKind!, forKey: "voornaamKind")
            nieuweverdwaaldkind.setValue(kind.leeftijd!, forKey: "leeftijd")
            nieuweverdwaaldkind.setValue(kind.url, forKey: "url")
            nieuweverdwaaldkind.setValue(kind.laatst_gezien, forKey: "laatst_gezien")
            nieuweverdwaaldkind.setValue(kind.vermist_sinds, forKey: "vermist_sinds")
            
            do{
                try managedContext?.save()
                print("Het kind is saved")
            }
            catch{
                fatalError("Failed to insert childs: \(error)")
            }
            
            if let kindLayoutView = Bundle.main.loadNibNamed("KindDetail", owner: self, options: nil)?.first as? KindDetailView {
                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                // Reference to an image file in Firebase Storage
                //print(storageRef.bucket)
                let reference = storageRef.child(kind.url!)
                // Create a reference to the file you want to download
                
                let imageView: UIImageView = kindLayoutView.imgKind
                
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                //print(reference)
                reference.getData(maxSize: 1 * 3072 * 3072) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                        print(error)
                        print("doesnt work")
                    } else {
                        // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        imageView.image = image
                    }
                }
                
                //str + "\(variable)"
                
                kindLayoutView.frame.origin.y = CGFloat(index) * 480
                kindLayoutView.lblNaamOuder.text = "\(kind.naamOuder!) " + "\(kind.voornaamOuder!)"
                kindLayoutView.lblRelatie.text = "\(kind.relatie!)" + " van " + "\(kind.voornaamKind!)"
                kindLayoutView.lblNaamKind.text = "\(kind.naamKind!) " + "\(kind.voornaamKind!)" + " vermist!"
                kindLayoutView.lblBeschrijving.text = kind.beschrijving
                
                kindScrollView.addSubview(kindLayoutView)
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
