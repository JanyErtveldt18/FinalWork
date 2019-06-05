//
//  FilterTableViewController.swift
//  
//
//  Created by Jany Ertveldt on 24/05/2019.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import GeoFire
import FirebaseFirestore
import CoreData
import CoreLocation

enum selectedScope:Int {
    case naam = 0
    case locatie = 1
    case datum_vermist = 2
}

class FilterTableViewController: UITableViewController,UISearchBarDelegate {

    var searchbar = UISearchBar()
    
    let storage = Storage.storage()
    let storageRef = StorageReference()
    var alleKinderen = [Kind]()
    var filteredKinderen = [Kind]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchbarSetup()
        self.haalAlleKinderenOp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchbar.endEditing(true)
        // self.txtEditNaam.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchbar.resignFirstResponder()
        return(true)
    }
    
    //BRON - searchbar
    //https://www.youtube.com/watch?v=TMo7PuggHlc
    func searchbarSetup(){
        searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
        searchbar.showsScopeBar = true
        searchbar.scopeButtonTitles = ["Naam","Locatie","Datum vermist"]
        searchbar.delegate = self
        self.tableView.tableHeaderView = searchbar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterTableView(ind: searchBar.selectedScopeButtonIndex,text: searchText)
    }
    
    func haalAlleKinderenOp(){
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
                    self.alleKinderen.append(kind)
                }
                print("alleKinderen")
//                print(self.alleKinderen)
            }
        }
    }
   
    func filterTableView(ind:Int,text:String){
        
        switch ind {
        case selectedScope.naam.rawValue:
            for(index) in self.alleKinderen.enumerated() {
                print(index.offset)
                
                if text == alleKinderen[index.offset].naamKind || text == alleKinderen[index.offset].voornaamKind{
                    print("De naam is gevonden aan de hand van de naam ")
                    print(alleKinderen[index.offset].voornaamKind!)
                    filteredKinderen.append(alleKinderen[index.offset])
                    
                    print("filteredKinderen")
                    print(filteredKinderen.count)
                    print(filteredKinderen)
                    self.tableView.reloadData()
                    
                }else{
                    //filteredKinderen.removeAll()
//                    self.tableView.reloadData()
                    //print("foute naam")
                }
            }
            
        case selectedScope.locatie.rawValue:
            for(index) in self.alleKinderen.enumerated() {
                if text == alleKinderen[index.offset].laatst_gezien {
                    print("De naam is gevonden aan de hand van locatie")
                    print(alleKinderen[index.offset].voornaamKind!)
                    filteredKinderen.append(alleKinderen[index.offset])
                    self.tableView.reloadData()
                    //print(filteredKinderen)
                }else{
//                    filteredKinderen.removeAll()
//                    self.tableView.reloadData()
                    //print("foute naam")
                }
            }
            
        case selectedScope.datum_vermist.rawValue:
            for(index) in self.alleKinderen.enumerated() {
                if  text == alleKinderen[index.offset].vermist_sinds {
                    print("De naam is gevonden aan de hand van datum")
                    print(alleKinderen[index.offset].voornaamKind!)
                    filteredKinderen.append(alleKinderen[index.offset])
                    self.tableView.reloadData()
                   // print(filteredKinderen)
                }else{
//                    filteredKinderen.removeAll()
//                    self.tableView.reloadData()
                    //print("foute naam")
                }
            }
            
        default:
            print("Geen resultaat")
        }
        
        if text.isEmpty {
            filteredKinderen.removeAll()
            self.tableView.reloadData()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredKinderen.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        

        let reference = storageRef.child(self.filteredKinderen[indexPath.row].url!)
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
        
        cell.lblNaam.text = "Naam: \(self.filteredKinderen[indexPath.row].naamKind!)" + " " + "\(self.filteredKinderen[indexPath.row].voornaamKind!)"
        cell.lblLeeftijdKind.text = "Leeftijd: \(self.filteredKinderen[indexPath.row].leeftijd!)"
        cell.lblLaatstGezien.text = "Laatst gezien: \(self.filteredKinderen[indexPath.row].laatst_gezien!)"
        cell.lblVermistSinds.text = "Vermist sinds: \(self.filteredKinderen[indexPath.row].vermist_sinds!)"
        
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let detailViewConroller = self.storyboard?.instantiateViewController(withIdentifier: "detailViewControllerID") as! DetailKindViewController
        
        detailViewConroller.naamKind = self.filteredKinderen[indexPath.row].naamKind
        detailViewConroller.voornaamKind = self.filteredKinderen[indexPath.row].voornaamKind
        detailViewConroller.leeftijdKind = "\(self.filteredKinderen[indexPath.row].leeftijd!)"
        detailViewConroller.beschrijvingKind = self.filteredKinderen[indexPath.row].beschrijving
        detailViewConroller.naamOuders = "\(self.filteredKinderen[indexPath.row].naamOuder!) " + "\(self.filteredKinderen[indexPath.row].voornaamOuder!)"
        
        detailViewConroller.laatst_gezien = "\(self.filteredKinderen[indexPath.row].laatst_gezien!)"
        
        detailViewConroller.imagereference = "\(self.filteredKinderen[indexPath.row].url!)"
        self.navigationController?.pushViewController(detailViewConroller, animated: true)
    }
    
    
    //Sluit keyboard na zoeken of scrollen
    //https://www.youtube.com/watch?v=Kp1PFw02Opc
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchbar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.endEditing(true)
    }
    
}
