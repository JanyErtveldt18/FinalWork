//
//  FilterLijstViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 24/05/2019.
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

class FilterLijstViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchbarSetup()
        // Do any additional setup after loading the view.
    }
    
    func searchbarSetup(){
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width), height: 70))
        searchbar.showsScopeBar = true
        searchbar.delegate = self
        self.tableView.tableHeaderView = searchbar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterTableView(ind: searchBar.selectedScopeButtonIndex,text: searchText)
    }
    
    func filterTableView(ind:Int,text:String){
        print(text)
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
