//
//  LijstTableViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 02/04/2019.
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



class LijstTableViewController: UITableViewController {
    
    
    let storage = Storage.storage()
    let storageRef = StorageReference()
    
//    var alleVerdwaaldeKinderen = [VerdwaaldKind]()
    var alleVerdwaaldeKinderenKind = [Kind]()
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
       
        self.haalAllesOpVanDatabase()
//        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "VerdwaaldKind")
//        do{
//            alleVerdwaaldeKinderen = try managedContext?.fetch(stationFetch) as! [VerdwaaldKind]
//
//            if (alleVerdwaaldeKinderen.count) > 0{
//                print("goeie stap")
//            }
//        }catch{
//
//        }
        
      
       
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
                    self.alleVerdwaaldeKinderenKind.append(kind)
                }
                print("alleVerdwaaldeKinderenKind")
                print(self.alleVerdwaaldeKinderenKind)
                self.tableView.reloadData()
//                self.voegZeAanEniteitToe()
            }
        }
    }
    
//    func voegZeAanEniteitToe(){
//        maakAllesLeegEerst()
//        for(index,kind) in self.alleVerdwaaldeKinderenKind.enumerated() {
//            let nieuweverdwaaldkind = NSEntityDescription.insertNewObject(forEntityName: "VerdwaaldKind", into: managedContext!)
//            nieuweverdwaaldkind.setValue(kind.naamKind!, forKey: "naamKind")
//            nieuweverdwaaldkind.setValue(kind.voornaamKind!, forKey: "voornaamKind")
//            nieuweverdwaaldkind.setValue(kind.leeftijd!, forKey: "leeftijd")
//            nieuweverdwaaldkind.setValue(kind.url, forKey: "url")
//            nieuweverdwaaldkind.setValue(kind.laatst_gezien, forKey: "laatst_gezien")
//            nieuweverdwaaldkind.setValue(kind.vermist_sinds, forKey: "vermist_sinds")
//            do{
//                try managedContext?.save()
//                print("Het kind is saved")
//            }
//            catch{
//                fatalError("Failed to insert childs: \(error)")
//            }
//          }
//    }
    
//    func maakAllesLeegEerst(){
//        //Core data legen want anders blijven de kinderen iedere keer opslaan
//        var alleVerdwaaldeKinderenTest = [VerdwaaldKind]()
//        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "VerdwaaldKind")
//        do{
//            alleVerdwaaldeKinderenTest = try managedContext?.fetch(stationFetch) as! [VerdwaaldKind]
//
//            if (alleVerdwaaldeKinderenTest.count) >= 0{
//                print("verwijder eerst alles")
//                for verdwaaldKind in alleVerdwaaldeKinderenTest{
//                    managedContext?.delete(verdwaaldKind)
//                    try! managedContext?.save()
//                }
//
//            }else{
//                print("niets te verwijderen")
//            }
//
//        }catch{
//
//        }
//    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return alleVerdwaaldeKinderenKind.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        let reference = storageRef.child(alleVerdwaaldeKinderenKind[indexPath.row].url!)
       
        
        reference.getData(maxSize: 1 * 3072 * 3072) { data, error in
            if let error = error {
                print(error)
                print("doesnt work")
            } else {
                let image = UIImage(data: data!)
                print(data!)
                cell.imageKind.image = image
            }
        }
        
        let naam = alleVerdwaaldeKinderenKind[indexPath.row].voornaamKind
        let voornaam = alleVerdwaaldeKinderenKind[indexPath.row].naamKind
        let laatst_gezien = alleVerdwaaldeKinderenKind[indexPath.row].laatst_gezien
        let vermist_sinds = alleVerdwaaldeKinderenKind[indexPath.row].vermist_sinds
        //cell.lblVoornaamKind.text = "Voornaam: \(voornaam!)"
        cell.lblNaam.text = "Naam: \(voornaam!) \(naam!)"
        cell.lblLeeftijdKind.text = "Leeftijd: \(alleVerdwaaldeKinderenKind[indexPath.row].leeftijd!) jaar"
        cell.lblLaatstGezien.text = "Laatst gezien : \(laatst_gezien!)"
        cell.lblVermistSinds.text = "Vermist sinds : \(vermist_sinds!)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let detailViewConroller = self.storyboard?.instantiateViewController(withIdentifier: "detailViewControllerID") as! DetailKindViewController
       
        detailViewConroller.naamKind = self.alleVerdwaaldeKinderenKind[indexPath.row].naamKind
        detailViewConroller.voornaamKind = self.alleVerdwaaldeKinderenKind[indexPath.row].voornaamKind
        detailViewConroller.leeftijdKind = "\(self.alleVerdwaaldeKinderenKind[indexPath.row].leeftijd!)"
        detailViewConroller.beschrijvingKind = self.alleVerdwaaldeKinderenKind[indexPath.row].beschrijving
        detailViewConroller.naamOuders = "\(self.alleVerdwaaldeKinderenKind[indexPath.row].naamOuder!) " + "\(self.alleVerdwaaldeKinderenKind[indexPath.row].voornaamOuder!)"
        
        detailViewConroller.laatst_gezien = "\(self.alleVerdwaaldeKinderenKind[indexPath.row].laatst_gezien!)"
        
        detailViewConroller.imagereference = "\(self.alleVerdwaaldeKinderenKind[indexPath.row].url!)"
        self.navigationController?.pushViewController(detailViewConroller, animated: true)
    }
    
    
    
}
